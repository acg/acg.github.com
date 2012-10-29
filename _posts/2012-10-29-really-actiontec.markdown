---
layout: post
title: Really, Actiontec?
root: ../../..
---

From a Verizon-branded Actiontec DSL router. Look for `adminPassword` in the javascript below...

    $ printf "GET / HTTP/1.1\r\n\r\n" | nc 192.168.1.1 80

    HTTP/1.1 200 Ok
    Server: micro_httpd
    Cache-Control: no-cache
    Date: Mon, 29 Oct 2012 17:50:28 GMT
    Content-Type: text/html
    Connection: close

    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Actiontec</title>
    <script language="JavaScript" src="js/nav.js"></script>
    <script language="Javascript">

    var adminPassword = "abc123";
    function do_load(){

            if(adminPassword == "abc123")
                    window.top.location.href='login.html';
            else
                    window.top.location.href='index_real.html';
    }
    </script>
    </head>

    <body onload="do_load()">
    <form  name="myform">

    </form>
    </body>
    </html>

