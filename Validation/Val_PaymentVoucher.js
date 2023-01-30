/*Validation Of DRS Settlement Details*/
function validateDRSSettlementDetails() {
    var check = true;
    if ($('.Txt_PaymentVNo').val() != '') {
        if ($('.Txt_PaymentDate').val() != '') {
            if ($('.Txt_NatureofExpence').val() != '') {
                if ($('.Txt_Amount').val() != '') {
                    if ($('.Txt_ReceiverName').val() != '') {

                    } else {
                        check = false;
                        $('.Txt_ReceiverName').tooltip({
                            placement: "top",
                            title: "Enter Name",
                            trigger: "focus"

                        });
                        $('.Txt_ReceiverName').focus();
                    }
                } else {
                    check = false;
                    $('.Txt_Amount').tooltip({
                        placement: "top",
                        title: "Enter Amount",
                        trigger: "focus"

                    });
                    $('.Txt_Amount').focus();
                }
            } else {
                check = false;
                $('.Txt_NatureofExpence').tooltip({
                    placement: "top",
                    title: "Enter Nature Of Expenses",
                    trigger: "focus"

                });
                $('.Txt_NatureofExpence').focus();
            }
        } else {
            check = false;
            $('.Txt_PaymentDate').tooltip({
                placement: "top",
                title: "Enter Date",
                trigger: "focus"

            });
            $('.Txt_PaymentDate').focus();
        }
    } else {
        check = false;
        $('.Txt_PaymentVNo').tooltip({
            placement: "top",
            title: "Contact To Branch",
            trigger: "focus"

        });
        $('.Txt_PaymentVNo').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}
function checkNumAlpha() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8 || event.keyCode == 32) {
        return true;
    }
    else {
        return false;
    }
}
function validateNumericValue(key) {
    var keycode = (key.which) ? key.which : key.keyCode;

    if (!(keycode == 8 || keycode == 46) && (keycode < 48 || keycode > 57)) {
        return false;
    }
    else {

        return true;
    }
}