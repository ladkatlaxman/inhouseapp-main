function validatePackageDetails()
{
    var check = true;
    if ($('.Txt_TypeOfPackage').val() != '')
    {
        var check = true;
    }
    else
    {
        check = false;
        $('.Txt_TypeOfPackage').tooltip({
            placement: "top",
            title: "Enter Type Of Package",
            trigger: "focus"
        });
        $('.Txt_TypeOfPackage').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}



function checkAlpha()
{

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8 || event.keyCode == 32) {
        return true;
    }
    else {
        return false;
    }
}