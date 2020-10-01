<?php
    include_once "./standalone.php";

    UmiCms\Service::Auth()->loginAsSv();
    //unlink(__FILE__);

    $buffer = outputBuffer::current('HTTPOutputBuffer');
    $buffer->redirect('/admin');