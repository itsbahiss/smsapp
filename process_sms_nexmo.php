<?php
require_once("config.php");
if( $_POST ){
	
	$sender_id = trim($_POST['sender_id']);
    $recepient_number = trim($_POST['recepient_number']);
	$send_message=trim($_POST['send_message']);
	$api_key='520e5f68';
	$secret_key='4a9c27bec50c534b';
	
	if($sender_id=="" || $recepient_number=="" || $send_message==""){

	?>
		<div class="alert alert-warning">
			<button type="button" class="close" data-dismiss="alert" aria-label="close"><span aria-hidden="true">&times;</span></button>
    		<strong>Failure</strong>, Please fill in all the required fields to proceed ...
		</div>
	<?php
		
	
	}else if(!preg_match("/^(\+?)([0-9] ?){9,20}$/", $sender_id) || !preg_match("/^(\+?)([0-9] ?){9,20}$/", $recepient_number)){
	?>
		<div class="alert alert-warning">
			<button type="button" class="close" data-dismiss="alert" aria-label="close"><span aria-hidden="true">&times;</span></button>
    		<strong>Failure</strong>, Please Sender ID and Recipient numbers provided are not valid ...
		</div>
		
	<?php
	}else{
	  
		echo $api_name;
		//echo $_SESSION["user_id"];
		$credits_query="select credits from credits where user_id=:uid";
		
		try{
			$stmt = $DB->prepare($credits_query);
			// bind the values
            $stmt->bindValue(":uid",$_SESSION["user_id"]);
            if($stmt->execute()==1){
				$results = $stmt->fetchAll();
				if(count($results) > 0 && $results[0]["credits"]>0){

						$url = 'https://rest.nexmo.com/sms/json?'. http_build_query([
							'api_key' =>  $api_key,
							'api_secret' => $secret_key,
							'to' => $recepient_number,
							'from' => $sender_id,
							'text' => $send_message
							]);
						$ch = curl_init($url);
					
						curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
						curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
						$response = curl_exec($ch);
						$decoded_response = json_decode($response, true);
						error_log('You sent ' . $decoded_response['message-count'] . ' messages.');

						foreach ( $decoded_response['messages'] as $message ) {
							if ($message['status'] == 0) {
								  $bal=trim((int)($results[0]["credits"]));
								  $bal_after=$bal-1;
								  
								  $sql = 'insert into message_info values (NOW(),"'.$sender_id.'","'.$recepient_number.'","'.$_SESSION["user_id"].'","'.$send_message.'","'.$bal.'","'.$bal_after.'");';
								  $sql2='update credits set credits="'.$bal_after.'" where user_id="'.$_SESSION["user_id"].'"';
								  
								  $stmt_insert=$DB->prepare($sql);
								  $stmt_update=$DB->prepare($sql2);
								  
								  if($stmt_insert->execute()==1 && $stmt_update->execute()==1){
										  ?>
											  <div class="alert alert-success">
												  <button type="button" class="close" data-dismiss="alert" aria-label="close"><span aria-hidden="true">&times;</span></button>
												  <strong>Success</strong>, Your message has been sent successfully ....
											  </div>
										  <?php	
										  error_log("Success " . $message['message-id']);
								  }
								
							} else {
										  ?>
											  <div class="alert alert-success">
												  <button type="button" class="close" data-dismiss="alert" aria-label="close"><span aria-hidden="true">&times;</span></button>
												  <strong>SMS Send Failure</strong>, Please contact gateway provider ....
											  </div>
										  <?php	
										  error_log("Error {$message['status']} {$message['error-text']}");
							}
						}
					

				
				}else{
				  ?>
						<div class="alert alert-warning">
							<button type="button" class="close" data-dismiss="alert" aria-label="close"><span aria-hidden="true">&times;</span></button>
							<strong>Failure</strong>, You dont have enough credits to send the message, Please load credit and try again 
						</div>
				  <?php 
				}
			}else{
			
			}
			
		}catch(Exception $ex){
		      ?>
			  <div class="alert alert-warning">
				<button type="button" class="close" data-dismiss="alert" aria-label="close"><span aria-hidden="true">&times;</span></button>
				<strong>Failure</strong>, <?php echo $ex; ?> ...
			  </div>		
			  <?php
		}
	 }

	?>
    
   
	
    <?php
	
}