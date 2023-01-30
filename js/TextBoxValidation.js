
/* Check Numbers Only*/

function pageLoad(sender, args) {
    $('.FirstNoSpaceAndZero').keypress(function (e) {
        if (this.value.length == 0 && (e.which == 48 || e.which == 32 || e.which == 46 || e.which == 45 || e.which == 47)) {
            return false;
        }
       
    });

    $('.NoFirstSpaceZeroAndDot').keypress(function (e) {
        //if (this.value.length == 0 && (e.which == 48 || e.which == 32 || e.which == 46)) {
        if (this.value.length == 0 && (e.which == 32 || e.which == 46)) {
            return false;
        }

    });

    /*Decimal Numeric*/
    $('.percentageValidation').keydown(function () {
        if ($(this).val() > 100) {
            alert("Please Enter Valid Percentage EqualTo OR Less Than 100");
            $(this).val('');
        }
    });

    //$('.DecimalNumber').keypress(function (e) {
    //    // function checkDecimalNumeric() {
    //    if ((event.keyCode > 47 && event.keyCode < 58) || event.keyCode == 8 || event.keyCode == 46) {
    //        return true;
    //    }
    //    else {
    //        return false;
    //    }
    //});

    //$('.SwitchEnterwithTab').keydown(function (e) {
    //    //if (e.keyCode === 13) {
    //        //MessageBox.Show("You pressed Enter");
    //      // alert("You pressed Enter");
    //       // Txt_Pickup_Pincode_Search.focus();
    //        // e.keyCode = 9;
    //        if (e.which == 13 ) {
    //          //  e.keyCode == 9;
    //            return false;
    //        }
    //   // }
    //});

        ///On UpdatePanel Refresh
        //var prm = Sys.WebForms.PageRequestManager.getInstance();
        //if (prm != null) {
        //    prm.add_endRequest(function (sender, e) {
        //        if (sender._postBackSettings.panelsToUpdate != null) {
        //            $(".FirstNotZero").keypress();
        //        }
        //    });
        //};
    
 
    //$(document).ready(function () {

    //    if ($("<%=Txt_Pickup_Pincode%>").is(":focus")) {
    //        $("<%=Panel_Pickup_Pincode%>").show();
    //    }
    //});

    //$("Txt_Pickup_Pincode").blur(function () {
    //    $("<%=Panel_Pickup_Pincode%>").hide
    //});
       
            $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                var $target = $(e.target);
                if ($target.parent().hasClass('disabled')) {
                    return false;
                }
            });
            $(".next-step").click(function (e) {
                var $active = $('.nav-tabs li.active');
                $active.next().removeClass('disabled');
                if ($active.next().attr('id') == $('[id*=UploadDocument]').attr('id')) {
                    $('[id*=hfLastStep]').val('true');
                }
                nextTab($active);                                                                   /////////// Open if not working properly //////////////
                return false;
            });

            //$('#butEdit_CustomerDataton').submit(function () {
            //    $("#myTab").tabs({
            //        active: $("#home")
            //    });
            //});

            //$(".first-tab").click(function (e) {
            //    var $active = $('.nav-tabs li.active');
            //    $active.next().removeClass('disabled');
            //    if ($active.first().attr('id') == $('[id*=View_Tab]').attr('id')) {
            //        $('[id*=hfFirstTab]').val('true');
            //    }
            //    firstTab($active);                                                                   
            //    return false;
            //    });

            $(".prev-step").click(function (e) {
                var $active = $('.nav-tabs li.active');
                prevTab($active);
                return false;
            });


            var tabId = '';
            $('[id*=myTab] li').each(function () {
                if ($('[id*=hfTabs]').val() != '') {

                    if ($(this).attr('id') == $('[id*=hfTabs]').val()) {
                        $(this).attr('class', 'active');
                        var tabpaneId = $(this).find('a').attr('href').split('#')[1];
                        $('.tab-pane').each(function () {
                            if ($(this).attr('id') == tabpaneId) {
                                $(this).attr('class', 'tab-pane active');
                            }
                            else {
                                $(this).attr('class', 'tab-pane');
                            }
                        });
                    }

                    //else if ($('[id*=hfTabs]').val() != '') {
                    //    if ($('[id*=View_Tab]').attr('id') == $(this).attr('id')) {
                    //        if ($('[id*=hfFirstTab]').val() == 'true') {
                    //            $(this).attr('class', '');
                    //        }
                    //    }
                    //}
                        
                    else {
                        if ($('[id*=UploadDocument]').attr('id') == $(this).attr('id')) {
                            if ($('[id*=hfLastStep]').val() == 'true') {
                                $(this).attr('class', '');
                            }
                        } else {
                            $(this).attr('class', '');
                        }
                    }



                }
            });

            $('.maintainTab').click(function () {
                $('[id*=hfTabs]').val($(this).closest('li').attr('id'));

            });
        }

    function nextTab(elem) {
        $(elem).next().find('a[data-toggle="tab"]').click();
        $('[id*=hfTabs]').val($(elem).next().attr('id'));

    }
    function prevTab(elem) {
        $(elem).prev().find('a[data-toggle="tab"]').click();
        $('[id*=hfTabs]').val($(elem).prev().attr('id'));
  
    }
    //function firstTab(elem) {
    //    $(elem).first().find('a[data-toggle="tab"]').click();
    //    $('[id*=hfTabs]').val($(elem).first().attr('id'));

    //}



function validate() {

    var txtvalue = document.getElementById('<%=textbox1.ClientID %>').value;

    if (txtvalue.charAt(0) == 0) {

        alert("0 shold not be first character");

        return false;

    }

}

//function FirstNotZero() {
//    if (this.value.length == 0 && event.keyCode == 48) {
//        return false;
//    }


//    //if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8 || event.keyCode == 32) {
//    //    return true;
//    //}
//    //else {
//    //    return false;
//    //}
//}

/*Numeric Value*/
function validateNumericValue(key) {
    var keycode = (key.which) ? key.which : key.keyCode;

    if (!(keycode >= 48 && keycode <= 57)) {
        return false;
    }
    return true;
}


/*Alpha Value*/
function checkNumAlpha() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8 || event.keyCode == 32) {

        return true;
    }
    else {
        return false;
    }
}


/*Alpha Numeric Value*/
function checkAlphaNumeric() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || (event.keyCode > 47 && event.keyCode < 58) || event.keyCode == 8) {
        return true;
    }
    else {
        return false;
    }
}

/*Alpha Numeric Value With Space*/
function checkAlphaNumericWithSpace() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || (event.keyCode > 47 && event.keyCode < 58) || event.keyCode == 8 || event.keyCode == 32) {
        return true;
    }
    else {
        return false;
    }
}

/* Numeric Value With Space*/
function checkNumericWithSpace() {

    if ((event.keyCode > 47 && event.keyCode < 58) || event.keyCode == 8 || event.keyCode == 32) {
        return true;
    }
    else {
        return false;
    }
}

/*Decimal Numeric*/
function checkDecimalNumeric() {

    if ((event.keyCode > 47 && event.keyCode < 58) || event.keyCode == 8 || event.keyCode == 46) {
        return true;
    }
    else {
        return false;
    }
}


/*Alpha  value with space and dot*/

function checkAlphaDotWithSpace() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 32) {
        return true;
    }
    else {
        return false;
    }
}

/*validations with sapce*/
function onlyAlphaValue() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8 || event.keyCode == 32) {
        return true;
    }
    else {
        return false;
    }
}


/*Check AlphaNumeric With Dot And Dash*/
function checkAlphaNumericWithDotAndDash() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || (event.keyCode > 43 && event.keyCode < 58) || event.keyCode == 8 || event.keyCode == 32) {
        return true;
    }
    else {
        return false;
    }
}

/*Check AlphaNumeric With only Dash*/
function checkAlphaNumericWithDash() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || (event.keyCode > 47 && event.keyCode < 58) || event.keyCode == 8 || event.keyCode == 32 || event.keyCode == 45) {
        return true;
    }
    else {
        return false;
    }
}



/*---------EmailId-----------*/
function checkEmailId() {

    if (event.keyCode == 32) {
        return false;
    }
    else {
        return true;
    }
}




