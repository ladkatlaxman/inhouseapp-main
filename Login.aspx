<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dexter Logistics</title>
    <link rel="shortcut icon" href="images/dexterLogo.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="fonts/css/font-awesome.min.css" rel="stylesheet" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css" />
    <!--===============================================================================================-->

    <link rel="stylesheet" type="text/css" href="css/util.css" />
    <link rel="stylesheet" type="text/css" href="css/main.css" />
    <style>
        @keyframes slideInFromLeft {
            0% {
                transform: translateY(-100%);
            }

            100% {
                transform: translateY(0);
            }
        }

        .pop {
            animation: 1s ease-out 0s 1 slideInFromLeft;
        }

        .alert {
            padding: 20px;
            background-color: #f44336;
            color: white;
            opacity: 1;
            transition: opacity 0.6s;
            margin-bottom: 15px;
        }

        .closebtn {
            margin-left: 15px;
            color: white;
            font-weight: bold;
            float: right;
            font-size: 22px;
            line-height: 20px;
            cursor: pointer;
            transition: 0.3s;
        }
            .closebtn:hover {
                color: black;
            }
    </style>
    <script type="text/javascript">
        window.onload = window.history.forward(0);
    </script>
</head>
<body>
     
    <div class="container-login100" style="background-image: url('images/login1.jpg');">
       
        <div class="wrap-login100 p-t-30 p-b-50 pop">
             <div class="alert" id="Alert" runat="server" visible="false">
            <span class="closebtn">&times;</span>
            <strong>Wrong! </strong>Username and Password
        </div>
            <%-- <span style="margin-left:130px;"> <img src="images/logo.png" style="height:60px;width:150px;" /> </span><br><br>--%>
            <span class="login100-form-title p-b-41">Login
            </span>
            <form class="login100-form  p-b-33 p-t-5" id="form1" runat="server">
                <span class="label-input100" style="margin-left: 130px;">
                    <img src="images/logo.png" style="height: 60px; width: 150px;" /></span>
                <div class="wrap-input100" data-validate="Enter username">
                    <%--validate-input--%>
                    <input class="input100" type="text" name="username" placeholder="USERNAME" runat="server" id="Txt_UserName" />
                    <span class="focus-input100" data-placeholder="&#xe82a;"></span>
                    <%--<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>--%>
                </div>
                <div class="wrap-input100 " data-validate="Enter password">
                    <%--validate-input--%>
                    <input class="input100" type="password" name="pass" placeholder="PASSWORD" runat="server" id="Txt_Password" />
                    <span class="focus-input100" data-placeholder="&#xe80f;"></span>
                </div>
                <div style="margin-left: 10px; margin-top: 10px">
                    <asp:Label ID="lblError" runat="server" Text=""></asp:Label> 
                </div>
                <div class="container-login100-form-btn m-t-32">
                    <button class="login100-form-btn submit-button " id="loginbtn" runat="server" onserverclick="loginbtn_ServerClick">Login</button>
                </div>
            </form>
        </div>
    </div>
    <script>
        var close = document.getElementsByClassName("closebtn");
        var i;

        for (i = 0; i < close.length; i++) {
            close[i].onclick = function () {
                var div = this.parentElement;
                div.style.opacity = "0";
                setTimeout(function () { div.style.display = "none"; }, 600);
            }
        }
    </script>
</body>
</html>
