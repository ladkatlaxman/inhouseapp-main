<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="VehicleLiveLocation.aspx.cs" Inherits="VehicleLiveLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDxuviIj3j9kfdOu1nPZkJq8DpEu-Kge4E"></script>

    <script type="text/javascript">
        window.onload = function () {
            var mapOptions = {
                center: new google.maps.LatLng(markers[0].lat, markers[0].lng),
                zoom: 4,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            var infoWindow = new google.maps.InfoWindow();
            var map = new google.maps.Map(document.getElementById("dvMap"), mapOptions);

            var data = markers[i]
            var myLatlng = new google.maps.LatLng(data.lat, data.lng);
            var marker = new google.maps.Marker({
                position: myLatlng,
                map: map,
                title: data.title
            });
            (function (marker, data) {
                google.maps.event.addListener(marker, "click", function (e) {
                    infoWindow.setContent(data.description);
                    infoWindow.open(map, marker);
                });
            })(marker, data);

        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:HiddenField runat="server" ID="hfLat" />
    <asp:HiddenField runat="server" ID="hfLong" />
    <asp:Label runat="server" ID="lblLocation" Font-Bold="true"></asp:Label>
    <iframe runat="server" id="iFrame" width="100%" height="450" frameborder="0" style="border:0"></iframe> <%--src="https://www.google.com/maps/embed/v1/place?q=18.299388,74.762326&amp;key=AIzaSyDxuviIj3j9kfdOu1nPZkJq8DpEu-Kge4E"--%>

</asp:Content>

