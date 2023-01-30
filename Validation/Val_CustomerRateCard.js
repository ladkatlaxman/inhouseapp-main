function validateRateCardDetails() {
    var check = true;
    if ($('.Txt_PopupRateType').val() != 'SELECT') {
        if ($('.Txt_PopupFromWeight').val() != '') {
            if ($('.Txt_PopupToWeight').val() != '') {
                if ($('.Txt_PopupFromDistance').val() != '') {
                    if ($('.Txt_PopupToDistance').val() != '') {
                        if ($('.Txt_RateValue').val() != '') {
                            check = true;
                        }
                        else {
                            check = false;
                            $('.Txt_RateValue').tooltip({
                                placement: "top",
                                title: "Enter Rate Value",
                                trigger: "focus"
                            });
                            $('.Txt_RateValue').focus();
                        }
                    }
                    else {
                        check = false;
                        $('.Txt_PopupToDistance').tooltip({
                            placement: "top",
                            title: "Enter To Distance",
                            trigger: "focus"
                        });
                        $('.Txt_PopupToDistance').focus();
                    }
                }
                else {
                    check = false;
                    $('.Txt_PopupFromDistance').tooltip({
                        placement: "top",
                        title: "Enter From Distance",
                        trigger: "focus"
                    });
                    $('.Txt_PopupFromDistance').focus();
                }
            }
            else {
                check = false;
                $('.Txt_PopupToWeight').tooltip({
                    placement: "top",
                    title: "Enter To Weight",
                    trigger: "focus"
                });
                $('.Txt_PopupToWeight').focus();
            }
        }
        else {
            check = false;
            $('.Txt_PopupFromWeight').tooltip({
                placement: "top",
                title: "Enter From Weight",
                trigger: "focus"
            });
            $('.Txt_PopupFromWeight').focus();
        }
    }
    else {
        check = false;
        $('.Txt_PopupRateType').tooltip({
            placement: "top",
            title: "Select Rate Type",
            trigger: "focus"
        });
        $('.Txt_PopupRateType').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}