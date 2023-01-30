function validateMaterialDetails() {
    var check = true;
    if ($('.Txt_MaterialName').val() != '') {
        var check = true;
    }
    else {
        check = false;
        $('.Txt_MaterialName').tooltip({
            placement: "top",
            title: "Enter Material Name",
            trigger: "focus"
        });
        $('.Txt_MaterialName').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}

function validateAddMaterial() {
    var check = true;
    if ($('.Ddl_Material option:selected').text() != 'SELECT') {
        if ($('.Txt_Qty').val() != '') {
            if ($('.Ddl_UOM option:selected').text() != 'SELECT') {
                if ($('.Txt_ExpectedDate').val() != '') {
                    var check = true;
                }
                else {
                    check = false;
                    $('.Txt_ExpectedDate').tooltip({
                        placement: "top",
                        title: "Enter Date",
                        trigger: "focus"
                    });
                    $('.Txt_ExpectedDate').focus();
                }
            }
            else {
                check = false;
                $('.Ddl_UOM').tooltip({
                    placement: "top",
                    title: "Select Unit",
                    trigger: "focus"
                });
                $('.Ddl_UOM').focus();
            }
        }
        else {
            check = false;
            $('.Txt_Qty').tooltip({
                placement: "top",
                title: "Enter Qty",
                trigger: "focus"
            });
            $('.Txt_Qty').focus();
        }
    } else {
        check = false;
        $('.Ddl_Material').tooltip({
            placement: "top",
            title: "Select Material Name",
            trigger: "focus"
        });
        $('.Ddl_Material').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}

function validatePurchaseMaterialDetails() {
    var check = true;
    if ($('.Ddl_Branch option:selected').text() != 'SELECT') {
        if ($('.Ddl_Department option:selected').text() != 'SELECT') {
            if ($('.Txt_Remark').val() != '') {
                    var check = true;
                }
                else {
                    check = false;
                    $('.Txt_Remark').tooltip({
                        placement: "top",
                        title: "Enter Remark",
                        trigger: "focus"
                    });
                    $('.Txt_Remark').focus();
                }
        }
        else {
            check = false;
            $('.Ddl_Department').tooltip({
                placement: "top",
                title: "Select Department",
                trigger: "focus"
            });
            $('.Ddl_Department').focus();
        }
    } else {
        check = false;
        $('.Ddl_Branch').tooltip({
            placement: "top",
            title: "Select Branch",
            trigger: "focus"
        });
        $('.Ddl_Branch').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}

function checkAlpha() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8 || event.keyCode == 32) {
        return true;
    }
    else {
        return false;
    }
}