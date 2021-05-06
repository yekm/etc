#!/bin/bash

boundary=`date +%s|md5sum`
boundary=${boundary:0:32}

att=$1

attid=$(md5sum $att)
attid="ii_${attid:0:16}"
mime=$(file -b --mime-type $att)
att_content=$(base64 $att)
att=$(basename $att)

html="<html>
<head>
<title>HTML E-mail</title>
</head>
<body>
Урррааа!!<br>
<img src="cid:$attid"><br>
</body>
</html>
"
html=$(echo "$html" | base64)


cat << EOF | msmtp -v -t
MIME-Version: 1.0
In-Reply-To: 
References: 
From: 
To: 
Cc: 
Subject: 
Content-Type: multipart/mixed; boundary="$boundary"

This is a MIME formatted message. If you see this message your browser suck.

--$boundary
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

$html


--$boundary
Content-Type: $mime; name="$att"
Content-Transfer-Encoding: base64
Content-ID: <$attid>
X-Attachment-Id: $attid

$att_content

--$boundary--


EOF

