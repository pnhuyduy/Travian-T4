<?php

    class Mailer
    {
        function sendActivate($email, $username, $pass, $act, $server)
        {
            $message = '<div class="body undoreset">Hello ' . $username . ',<br><br>Thank you for registering your Travian account!<br><br>You signed up for Travian world com1. To activate your account please click the<br>following link:<br><br><a rel="nofollow" target="_blank" href="' . HOMEPAGE . '/?code=' . $act . '&sv=' . $server . '#activation">' . HOMEPAGE . '/?code=' . $act . '&sv=' . $server . '#activation</a><br><br>---------------------------------------------------------------------------------------------------------------------------------<br><br>Your access data:<br><br>Player name:&nbsp; ' . $username . '<br>Email address: <a ymailto="mailto:' . $email . '" href="mailto:' . $email . '">' . $email . '</a><br>Password: ' . $pass . '<br>Game world: ' . $server . '<br><br>Activation code: ' . $act . '<br>Server Link: ' . HOMEPAGE . '/' . $server . '<br><br>---------------------------------------------------------------------------------------------------------------------------------<br><br>Game hints:<br>In our Travian Answers <a href="http://t4.answers.travian.com/ " target="_blank">http://t4.answers.travian.com/ </a>you will find answers for<br>many questions concerning Travian. You may also visit our forums at<br><a href="http://forum.travian.com " target="_blank">http://forum.travian.com </a>for relevant news and to communicate with other<br>players.<br><br>Have a good time and many glorious battles.<br><br>Your Travian Team<br><br>Impressum:<br>Travian Games GmbH, Wilhelm-Wagenfeld-Str. 22, 80807 M�nchen, Deutschland<br>Tel: +49 (0)89 3249150, Fax: +49 (0)89 324915970, www.traviangames.de<br>CEO: Siegfried M�ller<br>commercial court: Amtsgericht M�nchen, HRB 173511, <br>tax number: DE 246258085<br><br></div>';
            $subject = "Welcome to " . SERVER_NAME;
            $headers = "From: " . ADMIN_EMAIL . "\n";
            $headers .= "MIME-Version: 1.0\r\n";
            $headers .= "Content-Type: text/html;\n\tcharset=\"utf-8\"\r\n";
            mail($email, $subject, $message, $headers);
        }

        function sendActivate2($email, $username, $pass, $server)
        {
            $message = '<div class="body undoreset">Hello ' . $username . ',<br><br>Thank you for registering your Travian account!<br><br>You signed up for Travian. your account is activated so you dont need activation code .<br>---------------------------------------------------------------------------------------------------------------------------------<br><br>Your access data:<br><br>Player name:&nbsp; ' . $username . '<br>Email address: <a ymailto="mailto:' . $email . '" href="mailto:' . $email . '">' . $email . '</a><br>Password: ' . $pass . '<br>Server Link: ' . HOMEPAGE . '/' . $server . '<br><br>---------------------------------------------------------------------------------------------------------------------------------<br><br>Game hints:<br>In our Travian Answers <a href="http://t4.answers.travian.com/ " target="_blank">http://t4.answers.travian.com/ </a>you will find answers for<br>many questions concerning Travian. You may also visit our forums at<br><a href="http://forum.travian.com " target="_blank">http://forum.travian.com </a>for relevant news and to communicate with other<br>players.<br><br>Have a good time and many glorious battles.<br><br>Your Travian Team<br><br></div>';
            $subject = "Welcome to " . SERVER_NAME;
            $headers = "From: " . ADMIN_EMAIL . "\n";
            $headers .= "MIME-Version: 1.0\r\n";
            $headers .= "Content-Type: text/html;\n\tcharset=\"utf-8\"\r\n";
            mail($email, $subject, $message, $headers);
        }

        function sendinvitation($email, $username, $id, $server, $msg)
        {
            if (!empty($msg)) {
                $msg = 'Your friends message : ' . $msg;
            }
            $message = '<div class="body undoreset">Hello ,<br><br>This is an invitation for travian server from one of your friends who is playing currently in this game world , Come and Try the new game world<br>---------------------------------------------------------------------------------------------------------------------------------<br><br>' . $msg . '<br><br>Server Link:<a rel="nofollow" target="_blank" href="' . HOMEPAGE . '?server=' . $server . '&uc=ref_' . $id . '#serverRegister">' . HOMEPAGE . '?server=' . $server . '&uc=ref_' . $id . '#serverRegister</a><br><br>Best regards,TravianX</div>';

            $subject = ' Travian ' . $server . ' Invitation ';
            $headers = "From: " . ADMIN_EMAIL . "\n";
            $headers .= 'MIME-Version: 1.0\r\n';
            $headers .= 'Content-Type: text/html;\n\tcharset=\'utf-8\'\r\n';
            mail($email, $subject, $message, $headers);
        }

        function sendPassword($email, $uid, $username, $npw, $cpw)
        {

            $subject = "Password forgotten";

            $message = "Hello " . $username . "

You have requested a new password for Travian.

Please click this link to activate your new password. The old password then
becomes invalid:

http://${_SERVER['HTTP_HOST']}/" . sv_ . "/password.php?cpw=$cpw&npw=$npw&user=$username


----------------------------
Name: " . $username . "
Password: " . $npw . "
----------------------------

If you want to change your new password, you can enter a new one in your profile
on tab \"account\".

In case you did not request a new password you may ignore this email.

Best regards,TravianX
";

            $headers = "From: " . ADMIN_EMAIL . "\n";

            mail($email, $subject, $message, $headers);
        }

    }

    $mailer = new Mailer;
?>
