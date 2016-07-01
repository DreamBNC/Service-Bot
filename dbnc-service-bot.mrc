;-----------------CONFIG-----------------
alias config.load {
echo -a Loading config...
echo -a Setting BNC servers...
set %bncserver1 Vortex
set %bncserver2 Keith
set %bncserver3 Mercury
echo -a Done setting BNC servers. (25%)
echo -a Setting staff members...
set %staffmember1 W24
set %staffmember2 F4ncy
set %staffmember3 xerox123
set %staffmember4 HG
echo -a Loaded staff members. (50%)
echo -a Loading provider info...
set %bncwebsite DreamBNC.xyz
echo -a BNC website set. (60%)
set %bncchan #DreamBNC
echo -a BNC channel set. (70%)
set %staffchan #DreamBNC-Staff
echo -a Staff channel set. (80%)
set %bncprovider DreamBNC
echo -a BNC provider name set. (90%)
set %slogan Bouncers like a dream!
echo -a Slogan set. (100%)
echo -a Configuration completed successfully!
}
---------------END CONFIG------------------
ON 1:JOIN:#: notice $nick 2Welcome to 3the channel of10$+ %bncprovider $+ 2, a free BNC provider! To request a BNC, type !request <username> <email> <network> <port> 	Ex. !request John john@gmail.com irc.rizon.net 6667
ON *:TEXT:!report *:#: notice $nick 3Your report was sent and will be reviewed by a staff member within 48 hours. If you have made an error, just re-report it. Details: $2-  | msg %staffchan $nick has opened a new report. Server: $2 Username: $3 Issue: $4
ON *:TEXT:!remove *:#: notice $nick 3Your remove was submitted and will be reviewed by a staff member within 48 hours. | msg %adminchan $nick has requested to remove their BNC. Server: $2 Username $3 Network(s): $4


ON *:TEXT:!accept %bncserver1 *:#: {
  if ( $chan == %staffchan ) {
    msg %bncchan [ACCEPT] Request from $3 was 3ACCEPTED by $nick $+ . This account has been located on the server, %bncserver1 $+ . Details have been emailed to $6 $+ . | set %pending none | msg *controlpanel adduser $3 $4 | msg *controlpanel addnetwork $3 $5 | msg *controlpanel addserver $3 $5 $6 | %bncserver1 $+ .accept $6
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!accept %bncserver2 *:#: {
  if ( $chan == %staffchan ) {
    msg %bncchan [ACCEPT] Request from $3 was 3ACCEPTED by $nick $+ . This account has been located on the server, %bncserver2 $+ . Please check the email you used to request this BNC for more information. | set %pending none
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!accept %bncserver3 *:#: {
  if ( $chan == %staffchan ) {
    msg %bncchan [ACCEPT] Request from $3 was 3ACCEPTED by $nick $+ . This account has been located on the server, %bncserver3 $+ . Please check the email you used to request this BNC for more information. | set %pending none
  }
  else msg $nick 5Access Denied.
}
;The pending feature doesn't work too well
ON *:TEXT:!pending:#: {
  if ( $chan == %staffchan ) {
    msg $chan Current pending request: %pending 
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!setnews *:#: {
  if ( $chan == %staffchan ) {
    set %news (Posted by $nick on $date $+ ) $2- | msg %bncchan NEWS] (Posted by $nick $+ ) $2-
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!clearnews:#: {
  if ( $chan == %staffchan ) {
    set %news None. | msg %staffchan $nick cleared the news.
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!topic *:#: {
  if ( $chan == %staffchan ) {
    topic %bncchan $2-
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!request *:#: {
  if ( %requests == on ) {
    msg %staffchan $nick has requested a BNC. Details: Username: $2 Email: $3 Network:$4 $5 | notice $nick Your request was sent and will be reviewed by a staff member within 48 hours. If you have made an error, just re-request it. Username: $2 Email: $3 Network: $4 $5 | set %pending Requested by $nick at $date $time $+ . Username: $2 Email: $3 Network: $4 $5 
  }
  else msg $chan Requests are currently locked for the reason, %requestreason $+ . Please check back later, sorry.
}

ON *:TEXT:!addnet *:#: {
  if ( %requests == on ) {
    msg %staffchan $nick has requested that a network be added to their account. Server: $2 Username: $3 Network: $4 $5 | notice $nick 3Your request was sent and will be reviewed by a staff member within 48 hours. If you have made an error, just re-request it. Server: $2 Username: $3 Network: $4 $5 | set %pending Requested by $nick at $date $time $+ . Details: $2-
  }
  else msg $chan Requests are currently locked for the reason, %requestreason $+ . Please check back later, sorry.
}

ON *:TEXT:!addserver *:#: {
  if ( $chan == %staffchan ) {
    msg *controlpanel addserver $2- | notice $nick Server added.
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!addnetwork *:#: {
  if ( $chan == %staffchan ) {
    msg *controlpanel addnetwork $2-
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!adduser *:#: {
  if ( $chan == %staffchan) {
    msg *controlpanel adduser $2 | notice $nick User added. | msg %adminchan[ADD] $nick added a new user. | msg *controlpanel set quitmsg $2 %bncprovider - %slogan - http:// $+ %bncwebsite | msg *controlpanel set realname $2 %bncprovider - %slogan
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!deluser *:#: {
  if ( $chan == %staffchan ) {
    msg *controlpanel set quitmsg $2 %bncprovider - %slogan - http:// $+ %bncwebsite - (Account removed by a staff member) | msg *controlpanel deluser $2 | notice $nick User deleted. | msg %staffchan [DELETE] $nick deleted the user $2-
  }
  else msg $nick 5Access Denied.
}


ON *:TEXT:!kick *:#: {
  if ( $chan == %staffchan ) {
    kick %bncchan $2-  
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!ban *:#: {
  if ( $chan == %staffchan ) {
    mode %bncchan +b $2
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!unban *:#: {
  if ( $chan == %staffchan ) {
    mode %bncchan $2
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!reject *:#: {
  if ( $chan == %staffchan) {
    msg %bncchan [REJECT] Request from $2 was 4REJECTED by $nick $+ . Details can be found in an email sent to the email you used to request your BNC. Reason: $3- | set %pending None.
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!renable *:#: {
  if ( $chan == %staffchan ) {
    set %requests on | msg %bncchan [REQUESTS] Requesting has been unlocked by $nick | set %requestreason $2-
  }
  else msg $nick 5Access Denied.
}
;!staffhelp is a bit outdated
ON *:TEXT:!staffhelp *:#: {
  if ( $chan == %staffchan ) {
    notice $nick Staff commands: !reject <username> Rejects a request - !accept <username> Accepts a request - !close <username> Closes a report - !announce <message> Makes a new announcement - !suspend <network> Suspendes the network
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!rdisable *:#: {
  if ( $chan == %staffchan ) {
    set %requests off | msg %bncchan [REQUESTS] Requesting has been locked by $nick for the reason, $2- | set %requestreason $2-
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!close *:#: {
  if ( $chan == %staffchan ) {
    msg %bncchan [REPORT] The report from $2 (located on the server, $3 $+ ) was closed by $nick $+ . Details: $4- $+ . This information has also been emailed the email address associated with this account.
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!announce *:#: {
  if ( $chan == %staffchan ) {
    msg %bncchan [ANNOUNCEMENT] (From $nick $+ ) $2- 
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!block *:#: {
  if ( $chan == %staffchan ) {
    msg %bncchan [BLOCK] The network, $2 has been blocked until futher notice. Reason: $3-
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!unblock *:#: {
  if ( $chan == %staffchan ) {
    msg %bncchan [UNBLOCK] The block on the network, $2 has been cancelled.
  }
  else msg $nick 5Access Denied.
}

ON *:TEXT:!staff:#: msg $chan The current staff members have been noticed to you, $nick $+ . | notice $nick Current staff members: %staffmember1 $+ , %staffmember2 $+ , %staffmember3 $+ & %staffmember4 $+ . More details can be found here: http:// $+ %bncwebsite $+ /staff
ON *:TEXT:!help:#: msg $chan 3A list of available commands have been noticed to you, $nick | notice $nick Available commands: help, staff, rules, panel, report, request, blocked, news, remove
ON *:TEXT:!rules:#: msg $chan 3 $nick $+ : Our rules/terms can be found here: http:// $+ %bncwebsite $+ /rules
ON *:TEXT:!panel:#: msg $chan $nick $+ : All webpanel links can be found here: http:// $+ %bncwebsite $+ /servers
ON *:TEXT:!report:#: msg $chan 3Syntax: !report <server> <username> <issue>
ON *:TEXT:!request:#: msg $chan 2Syntax: !request <username> <email> <network> <port> 14-2 One account per person, two networks allowed. | msg $chan 3If you would like to keep your email private, just email your request to info@ $+ %bncwebsite (Make sure to include the network host, port and a username) | msg $chan 4Please make sure to read our rules before requesting. http:// $+ %bncwebsite $+ /rules 
ON *:TEXT:!blocked:#: msg $chan 3$nick $+ : A list of blocked networks can be found here: %bncwebsite $+/banned
ON *:TEXT:!addnet:#: msg $chan 3Syntax: !addnet <username> <server> <network> <port> | msg $chan 4Please make sure to read our blocked networks list before requesting. http:// $+ %bncwebsite $+ /banned
ON *:TEXT:!remove:#: msg $chan 3Syntax: !remove <server> <username> <network> | msg $chan 4To remove your entire account, type "all" in the network field.
ON *:TEXT:!servers:#: msg $chan Current servers: 3 %bncserver1 $+ , %bncserver2 $+ & %bncserver3
ON *:TEXT:!news:#: msg $chan %news
; //////////////////////// EMAILS   /////////////////////////////////

alias email.accept {
  email.start debug

  email.from you@email.here my name
  email.to sned@email.here  asd
  email.subject I am testing a new EMAIL sending thingy

  email.body Hello. Your BNC request was accepted! Details are below.
  email.body 
  email.body right so I haven't set this up yet

  email.send my_erroralias

}

alias my_erroralias {
  if ($0) echo -b $1-
  else echo -b Mail Send Complete!
}

; /////////////////////////// END EMAILS ////////
; +-+-+-+-+-+-+-+-+-+-+-+-+-+
; +  Send Email With mIRC   +
; +  Author: Imrac          +
; +  Version: 1.2.0         +
; +  Date: Oct 8, 2011     +                   
; +-+-+-+-+-+-+-+-+-+-+-+-+-+

;Version Change Log:
/*
V 1.0.0 -- Initial Release (Mar 04, 2010)

V 1.1.0 -- (Aug 12, 2011)

* Added SSL support
* Changed to Authentication
* TESTED WITH GMAIL
* No need for NSlookup anymore

V 1.2.0 -- (Oct 08,2011)

* Fixed email.error alias typeo

*/
; /////////////////////////// USEAGE ///////////////////////////////////
; Step 1: Call /email.start (You may use debug as paramter 1 to display useful info)
; Step 2: Call /email.to/from/subject/body (doesn't matter order, as long as its all their)
; Step 3: Call /email.send (attempts to send the email, you can specify an error alias
;                                it will be called if an error occurs with info )

; Note: Body can be called multiple times with or without content ($crlf is sent if blank)

; /email.start [debug]
; /email.from <email_address> [Real Name]
; /email.to <email_address> [Real Name]
; /email.subject <subject>
; /email.body [your body here] Can be called multiple times
; /email.send [callback]

; callback alias will be blank if success, or return the error.!

; ----------------- MODIFY HERE -------------------------------

alias -l _email.server { return smtp.some.domain }
alias -l _email.port { return 587 }
alias -l _email.ssl { return $false }
alias -l _email.username { return your@email.address }
alias -l _email.password { return yourpass123 }

; ------------------ END MODIFY -------------------------------

alias email.start {
  if ($hget(email)) { hfree email }
  hadd -m email send_attempt false
  if ($1 == debug) { hadd -m email debug true }
}
alias email.to {
  if ($regex($1,/^(.*?)@(.*?)$/)) {
    hadd -m email to_full $1
    hadd -m email to_host $regml(2)
    hadd -m email to_name $2-
  }
}
alias email.from {
  if ($regex($1,/^(.*?)@(.*?)$/)) {
    hadd -m email from_full $1
    hadd -m email from_host $regml(2)
    hadd -m email from_name $2-
  }
}
alias email.subject { hadd -m email subject $1- }
alias email.body {  hadd -m email body_ $+ $calc($hfind(email,body_*,0,w) + 1) $1- }
alias email.send {
  hadd -m email error $1
  e.connect
  .timeremail 1 10 sockclose S_EMAIL 
}
alias -l e.connect {
  if (!$sock(email)) { sockopen $iif($_email.ssl,-e,) S_EMAIL $_email.server $_email.port }
  else { e.error Socket already in use }
}

alias -l e.write {
  if ($hget(email,debug)) { echo -a C: $iif($1 == -omit, <Omitted Output>, $1-) }
  sockwrite -n S_EMAIL $iif($1 == -omit, $2-, $1-)
}
alias -l e.error { if ($hget(email,error)) $v1 $1- }
alias -l e.finished { if ($hget(email,error)) $v1 }

on *:sockopen:S_EMAIL:{
  if ($sockerr) { e.error Unable to open socket  }
  else {  hadd -m email step 1 }
}

on *:SOCKREAD:S_EMAIL:{
  IF ($sockerr) { e.error Error reading socket }

  var %read 
  var %step $hget(email,step)
  sockread %read

  if ($hget(email,debug)) { echo -a S: %read }

  if ( ($regex(%read,/^(\d\d\d)([ -])(.*)$/)) && ($regml(2) != -) ) {

    var %code $regml(1)
    var %response $regml(3)

    if  ((%step == 1) && (%code == 220)) { e.write EHLO | hinc email step 1 } 
    elseif  ((%step == 2) && (%code == 250)) { e.write AUTH LOGIN | hinc email step 1 }
    elseif  ((%step == 3) && (%code == 334) && (%response == VXNlcm5hbWU6)) { e.write -omit $encode($_email.username,m) | hinc email step 1 }
    elseif  ((%step == 4) && (%code == 334) && (%response == UGFzc3dvcmQ6)) { e.write -omit $encode($_email.password,m) | hinc email step 1 }    
    elseif  ((%step == 5) && (%code == 235)) { e.write MAIL FROM: $+(<,$hget(email,from_full),>) | hinc email step 1  }   
    elseif  ((%step == 6) && (%code == 250)) { e.write RCPT TO: $+(<,$hget(email,to_full),>) | hinc email step 1  }
    elseif  ((%step == 7) && (%code == 250)) { e.write DATA | hinc email step 1 }
    elseif  ((%step == 8) && (%code == 354)) { 
      e.write From: $iif($hget(email,from_name),$qt($v1),) $+(<,$hget(email,from_full),>)
      e.write To: $iif($hget(email,to_name),$qt($v1),) $+(<,$hget(email,to_full),>)
      e.write Subject: $hget(email,subject)
      e.write 
      var %total = $hfind(email,body_*,0,w), %i = 1
      while (%i <= %total) { e.write $hget(email,$+(body_,%i)) | inc %i 1 }
      e.write .
      hinc email step 1
    }
    elseif  ((%step == 9) && (%code == 250)) { e.write QUIT | hinc email step 1 }
    elseif  ((%step == 10) && (%code == 221)) { e.finished }
    else { e.error %read } 
  }
}
on *:SOCKCLOSE:S_EMAIL:{ .timeremail off }
