/*Validation of Customer Creation*/

function validateCustomerDetails() {
    var check = true;
    var CompEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

            if ($('.Txt_CustomerName').val() != '') {
                if ($('.Txt_ContactNo').val() != '' && $('.Txt_ContactNo').val().length == 10) {
                    if ($('.Txt_CustEmailId').val() != '' && CompEmail.test($('.Txt_CustEmailId').val())) { 
                            if ($('.Txt_CreditLimit').val() != '') {
                                check = true;   
                            } else {
                                check = false;
                                $('.Txt_CreditLimit').tooltip({
                                    placement: "top",
                                    title: "Enter Credit Limit",
                                    trigger: "focus"
                                });
                                $('.Txt_CreditLimit').focus();
                            }
                    }
                    else {
                        check = false;
                        $('.Txt_CustEmailId').tooltip({
                            placement: "top",
                            title: "Enter Valid Email Id",
                            trigger: "focus"
                        });
                        $('.Txt_CustEmailId').focus();
                    }

                } else {
                    check = false;
                    $('.Txt_ContactNo').tooltip({
                        placement: "top",
                        title: "Enter Contact Number",
                        trigger: "focus"
                    });
                    $('.Txt_ContactNo').focus();
                }

            } else {
                check = false;
                $('.Txt_CustomerName').tooltip({
                    placement: "top",
                    title: "Enter Customer Name",
                    trigger: "focus"
                });
                $('.Txt_CustomerName').focus();
            }
        
    if (!check) {
        $("#hfButtonTab1Save").val(0);
        console.log($("#hfButtonTab1Save").val());
        return false;
    }
    else {
        $("#hfButtonTab1Save").val(1);
        console.log($("#hfButtonTab1Save").val());
        return true;
    }
}

function valAddCustomerDetails()
{
    var check = true;
    if ($('.Txt_Pincode').val() != '') {
        if ($('.Ddl_Area option:selected').text() != 'SELECT') {
            if ($('.Txt_BillingAddress').val() != '') {
                check = true;
            } else {
                check = false;
                $('.Txt_BillingAddress').tooltip({
                    placement: "top",
                    title: "Enter Billing Address",
                    trigger: "focus"
                });
                $('.Txt_BillingAddress').focus();
            }
        } else {
            check = false;
            $('.Ddl_Area').tooltip({
                placement: "top",
                title: "Select Area",
                trigger: "focus"
            });
            $('.Ddl_Area').focus();
        }

    } else {
        check = false;
        $('.Txt_Pincode').tooltip({
            placement: "top",
            title: "Select Pincode",
            trigger: "focus"
        });
        $('.Txt_Pincode').focus();
    }
    if (!check) {
        $("#hfAddCustomerBranch").val(0);
        //console.log($("#hfAddCustomerBranch").val());
        return false;
    }
    else {
        $("#hfAddCustomerBranch").val(1);
        //console.log($("#hfAddCustomerBranch").val());
        return true;
    }
}


function SalesPersonDetails() {
    var check = true;
    if ($('.Txt_SalesPerson').val() != '') {
        check = true;
    } else {
        check = false;
        $('.Txt_SalesPerson').tooltip({
            placement: "top",
            title: "Select Sales Person Name",
            trigger: "focus"
        });
        $('.Txt_SalesPerson').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}



function OtherPersonDetails() {
    var check = true;
    if ($('.Ddl_PersonDesignation option:selected').text() != 'SELECT') {
        if ($('.Txt_OtherPersonName').val() != '') {
            if ($('.Txt_OtherContactNo').val() != '') {
                check = true;
            } else {
                check = false;
                $('.Txt_OtherContactNo').tooltip({
                    placement: "top",
                    title: "Enter Contact No",
                    trigger: "focus"
                });
                $('.Txt_OtherContactNo').focus();
            }
        } else {
            check = false;
            $('.Txt_OtherPersonName').tooltip({
                placement: "top",
                title: "Enter Person Name",
                trigger: "focus"
            });
            $('.Txt_OtherPersonName').focus();
        }
    } else {
        check = false;
        $('.Ddl_PersonDesignation').tooltip({
            placement: "top",
            title: "Select Designation",
            trigger: "focus"
        });
        $('.Ddl_PersonDesignation').focus();
    }
    if (!check) {
        return false;
    }
    else {
        return true;
    }
}



/*Validation of Sales Person Details*/
function validateDocumentsDetails() {
    var check = true;
    if ($('.Txt_PanCardNo').val() == '') {
        if ($('.Txt_AdharcardNo').val() == '') {
            if ($('.Txt_CustomerGSTCertificates').val() == '') {
                if ($('.Txt_CustomerCIN').val() == '') {
                    if ($('.Txt_LogisticPanCardNo').val() == '') {
                        if ($('.Txt_LogisticAdharcardNo').val() == '') {
                            if ($('.Txt_FinancePanCardNo').val() == '') {
                                if ($('.Txt_FinanceAdharcardNo').val() == '') {
                                    if ($('.Txt_DirectorsPanCardNo').val() == '') {
                                        if ($('.Txt_DirectorAdharcardNo').val() == '') {

                                        }
                                        else if ($('.Txt_DirectorAdharcardNo').val() != '' && $('.Txt_DirectorAdharcardNo').val().length == 12) {

                                        } else {
                                            check = false;
                                            $('.Txt_DirectorAdharcardNo').tooltip({
                                                placement: "top",
                                                title: "Enter Correct Director Adhaarcard Number",
                                                trigger: "focus"
                                            });
                                            $('.Txt_DirectorAdharcardNo').focus();
                                        }
                                    }
                                    else if ($('.Txt_DirectorsPanCardNo').val() != '' && $('.Txt_DirectorsPanCardNo').val().length == 10) {
                                    } else {
                                        check = false;
                                        $('.Txt_DirectorsPanCardNo').tooltip({
                                            placement: "top",
                                            title: "Enter Correct Director Pancard Number",
                                            trigger: "focus"
                                        });
                                        $('.Txt_DirectorsPanCardNo').focus();
                                    }
                                }
                                else if ($('.Txt_FinanceAdharcardNo').val() != '' && $('.Txt_FinanceAdharcardNo').val().length == 12) {
                                } else {
                                    check = false;
                                    $('.Txt_FinanceAdharcardNo').tooltip({
                                        placement: "top",
                                        title: "Enter Correct Finance Adhaarcard Number",
                                        trigger: "focus"
                                    });
                                    $('.Txt_FinanceAdharcardNo').focus();
                                }
                            }
                            else if ($('.Txt_FinancePanCardNo').val() != '' && $('.Txt_FinancePanCardNo').val().length == 10) { } else {
                                check = false;
                                $('.Txt_FinancePanCardNo').tooltip({
                                    placement: "top",
                                    title: "Enter Correct Finance Pancard Number",
                                    trigger: "focus"
                                });
                                $('.Txt_FinancePanCardNo').focus();
                            }
                        }
                        else if ($('.Txt_LogisticAdharcardNo').val() != '' && $('.Txt_LogisticAdharcardNo').val().length == 12) {
                        }
                        else {
                            check = false;
                            $('.Txt_LogisticAdharcardNo').tooltip({
                                placement: "top",
                                title: "Enter Correct Logistic Adhaarcard Number",
                                trigger: "focus"
                            });
                            $('.Txt_LogisticAdharcardNo').focus();
                        }
                    }
                    else if ($('.Txt_LogisticPanCardNo').val() != '' && $('.Txt_LogisticPanCardNo').val().length == 10) { }
                    else {
                        check = false;
                        $('.Txt_LogisticPanCardNo').tooltip({
                            placement: "top",
                            title: "Enter Correct Logistic Pancard Number",
                            trigger: "focus"
                        });
                        $('.Txt_LogisticPanCardNo').focus();
                    }
                }
                else if ($('.Txt_CustomerCIN').val() != '' && $('.Txt_CustomerCIN').val().length == 21) {
                } else {
                    check = false;
                    $('.Txt_CustomerCIN').tooltip({
                        placement: "top",
                        title: "Enter Correct Customer CIN Number",
                        trigger: "focus"
                    });
                    $('.Txt_CustomerCIN').focus();
                }
            }
            else if ($('.Txt_CustomerGSTCertificates').val() != '' && $('.Txt_CustomerGSTCertificates').val().length == 15) {
            }
            else {
                check = false;
                $('.Txt_CustomerGSTCertificates').tooltip({
                    placement: "top",
                    title: "Enter Correct Customer GST Number",
                    trigger: "focus"
                });
                $('.Txt_CustomerGSTCertificates').focus();
            }
        }
        else if ($('.Txt_AdharcardNo').val() != '' && $('.Txt_AdharcardNo').val().length == 12) { }
        else {
            check = false;
            $('.Txt_AdharcardNo').tooltip({
                placement: "top",
                title: "Enter Correct Customer Aadharcard Number",
                trigger: "focus"
            });
            $('.Txt_AdharcardNo').focus();
        }

    }
    else if ($('.Txt_PanCardNo').val() != '' && $('.Txt_PanCardNo').val().length == 10) {
        if ($('.Txt_AdharcardNo').val() == '') {
            if ($('.Txt_CustomerGSTCertificates').val() == '') {
                if ($('.Txt_CustomerCIN').val() == '') {
                    if ($('.Txt_LogisticPanCardNo').val() == '') {
                        if ($('.Txt_LogisticAdharcardNo').val() == '') {
                            if ($('.Txt_FinancePanCardNo').val() == '') {
                                if ($('.Txt_FinanceAdharcardNo').val() == '') {
                                    if ($('.Txt_DirectorsPanCardNo').val() == '') {
                                        if ($('.Txt_DirectorAdharcardNo').val() == '') {

                                        }
                                        else if ($('.Txt_DirectorAdharcardNo').val() != '' && $('.Txt_DirectorAdharcardNo').val().length == 12) {

                                        } else {
                                            check = false;
                                            $('.Txt_DirectorAdharcardNo').tooltip({
                                                placement: "top",
                                                title: "Enter Correct Director Adhaarcard Number",
                                                trigger: "focus"
                                            });
                                            $('.Txt_DirectorAdharcardNo').focus();
                                        }
                                    }
                                    else if ($('.Txt_DirectorsPanCardNo').val() != '' && $('.Txt_DirectorsPanCardNo').val().length == 10) {
                                    } else {
                                        check = false;
                                        $('.Txt_DirectorsPanCardNo').tooltip({
                                            placement: "top",
                                            title: "Enter Correct Director Pancard Number",
                                            trigger: "focus"
                                        });
                                        $('.Txt_DirectorsPanCardNo').focus();
                                    }
                                }
                                else if ($('.Txt_FinanceAdharcardNo').val() != '' && $('.Txt_FinanceAdharcardNo').val().length == 12) {
                                } else {
                                    check = false;
                                    $('.Txt_FinanceAdharcardNo').tooltip({
                                        placement: "top",
                                        title: "Enter Correct Finance Adhaarcard Number",
                                        trigger: "focus"
                                    });
                                    $('.Txt_FinanceAdharcardNo').focus();
                                }
                            }
                            else if ($('.Txt_FinancePanCardNo').val() != '' && $('.Txt_FinancePanCardNo').val().length == 10) { } else {
                                check = false;
                                $('.Txt_FinancePanCardNo').tooltip({
                                    placement: "top",
                                    title: "Enter Correct Finance Pancard Number",
                                    trigger: "focus"
                                });
                                $('.Txt_FinancePanCardNo').focus();
                            }
                        }
                        else if ($('.Txt_LogisticAdharcardNo').val() != '' && $('.Txt_LogisticAdharcardNo').val().length == 12) {
                        }
                        else {
                            check = false;
                            $('.Txt_LogisticAdharcardNo').tooltip({
                                placement: "top",
                                title: "Enter Correct Logistic Adhaarcard Number",
                                trigger: "focus"
                            });
                            $('.Txt_LogisticAdharcardNo').focus();
                        }
                    }
                    else if ($('.Txt_LogisticPanCardNo').val() != '' && $('.Txt_LogisticPanCardNo').val().length == 10) { }
                    else {
                        check = false;
                        $('.Txt_LogisticPanCardNo').tooltip({
                            placement: "top",
                            title: "Enter Correct Logistic Pancard Number",
                            trigger: "focus"
                        });
                        $('.Txt_LogisticPanCardNo').focus();
                    }
                }
                else if ($('.Txt_CustomerCIN').val() != '' && $('.Txt_CustomerCIN').val().length == 21) {
                } else {
                    check = false;
                    $('.Txt_CustomerCIN').tooltip({
                        placement: "top",
                        title: "Enter Correct Customer CIN Number",
                        trigger: "focus"
                    });
                    $('.Txt_CustomerCIN').focus();
                }
            }
            else if ($('.Txt_CustomerGSTCertificates').val() != '' && $('.Txt_CustomerGSTCertificates').val().length == 15) {
            }
            else {
                check = false;
                $('.Txt_CustomerGSTCertificates').tooltip({
                    placement: "top",
                    title: "Enter Correct Customer GST Number",
                    trigger: "focus"
                });
                $('.Txt_CustomerGSTCertificates').focus();
            }
        }
        else if ($('.Txt_AdharcardNo').val() != '' && $('.Txt_AdharcardNo').val().length == 12) {
            if ($('.Txt_CustomerGSTCertificates').val() == '') {
                if ($('.Txt_CustomerCIN').val() == '') {
                    if ($('.Txt_LogisticPanCardNo').val() == '') {
                        if ($('.Txt_LogisticAdharcardNo').val() == '') {
                            if ($('.Txt_FinancePanCardNo').val() == '') {
                                if ($('.Txt_FinanceAdharcardNo').val() == '') {
                                    if ($('.Txt_DirectorsPanCardNo').val() == '') {
                                        if ($('.Txt_DirectorAdharcardNo').val() == '') {

                                        }
                                        else if ($('.Txt_DirectorAdharcardNo').val() != '' && $('.Txt_DirectorAdharcardNo').val().length == 12) {

                                        } else {
                                            check = false;
                                            $('.Txt_DirectorAdharcardNo').tooltip({
                                                placement: "top",
                                                title: "Enter Correct Director Adhaarcard Number",
                                                trigger: "focus"
                                            });
                                            $('.Txt_DirectorAdharcardNo').focus();
                                        }
                                    }
                                    else if ($('.Txt_DirectorsPanCardNo').val() != '' && $('.Txt_DirectorsPanCardNo').val().length == 10) {
                                    } else {
                                        check = false;
                                        $('.Txt_DirectorsPanCardNo').tooltip({
                                            placement: "top",
                                            title: "Enter Correct Director Pancard Number",
                                            trigger: "focus"
                                        });
                                        $('.Txt_DirectorsPanCardNo').focus();
                                    }
                                }
                                else if ($('.Txt_FinanceAdharcardNo').val() != '' && $('.Txt_FinanceAdharcardNo').val().length == 12) {
                                } else {
                                    check = false;
                                    $('.Txt_FinanceAdharcardNo').tooltip({
                                        placement: "top",
                                        title: "Enter Correct Finance Adhaarcard Number",
                                        trigger: "focus"
                                    });
                                    $('.Txt_FinanceAdharcardNo').focus();
                                }
                            }
                            else if ($('.Txt_FinancePanCardNo').val() != '' && $('.Txt_FinancePanCardNo').val().length == 10) { } else {
                                check = false;
                                $('.Txt_FinancePanCardNo').tooltip({
                                    placement: "top",
                                    title: "Enter Correct Finance Pancard Number",
                                    trigger: "focus"
                                });
                                $('.Txt_FinancePanCardNo').focus();
                            }
                        }
                        else if ($('.Txt_LogisticAdharcardNo').val() != '' && $('.Txt_LogisticAdharcardNo').val().length == 12) {
                        }
                        else {
                            check = false;
                            $('.Txt_LogisticAdharcardNo').tooltip({
                                placement: "top",
                                title: "Enter Correct Logistic Adhaarcard Number",
                                trigger: "focus"
                            });
                            $('.Txt_LogisticAdharcardNo').focus();
                        }
                    }
                    else if ($('.Txt_LogisticPanCardNo').val() != '' && $('.Txt_LogisticPanCardNo').val().length == 10) { }
                    else {
                        check = false;
                        $('.Txt_LogisticPanCardNo').tooltip({
                            placement: "top",
                            title: "Enter Correct Logistic Pancard Number",
                            trigger: "focus"
                        });
                        $('.Txt_LogisticPanCardNo').focus();
                    }
                }
                else if ($('.Txt_CustomerCIN').val() != '' && $('.Txt_CustomerCIN').val().length == 21) {
                } else {
                    check = false;
                    $('.Txt_CustomerCIN').tooltip({
                        placement: "top",
                        title: "Enter Correct Customer CIN Number",
                        trigger: "focus"
                    });
                    $('.Txt_CustomerCIN').focus();
                }
            }
            else if ($('.Txt_CustomerGSTCertificates').val() != '' && $('.Txt_CustomerGSTCertificates').val().length == 15) {
                if ($('.Txt_CustomerCIN').val() == '') {
                    if ($('.Txt_LogisticPanCardNo').val() == '') {
                        if ($('.Txt_LogisticAdharcardNo').val() == '') {
                            if ($('.Txt_FinancePanCardNo').val() == '') {
                                if ($('.Txt_FinanceAdharcardNo').val() == '') {
                                    if ($('.Txt_DirectorsPanCardNo').val() == '') {
                                        if ($('.Txt_DirectorAdharcardNo').val() == '') {

                                        }
                                        else if ($('.Txt_DirectorAdharcardNo').val() != '' && $('.Txt_DirectorAdharcardNo').val().length == 12) {

                                        } else {
                                            check = false;
                                            $('.Txt_DirectorAdharcardNo').tooltip({
                                                placement: "top",
                                                title: "Enter Correct Director Adhaarcard Number",
                                                trigger: "focus"
                                            });
                                            $('.Txt_DirectorAdharcardNo').focus();
                                        }
                                    }
                                    else if ($('.Txt_DirectorsPanCardNo').val() != '' && $('.Txt_DirectorsPanCardNo').val().length == 10) {
                                    } else {
                                        check = false;
                                        $('.Txt_DirectorsPanCardNo').tooltip({
                                            placement: "top",
                                            title: "Enter Correct Director Pancard Number",
                                            trigger: "focus"
                                        });
                                        $('.Txt_DirectorsPanCardNo').focus();
                                    }
                                }
                                else if ($('.Txt_FinanceAdharcardNo').val() != '' && $('.Txt_FinanceAdharcardNo').val().length == 12) {
                                } else {
                                    check = false;
                                    $('.Txt_FinanceAdharcardNo').tooltip({
                                        placement: "top",
                                        title: "Enter Correct Finance Adhaarcard Number",
                                        trigger: "focus"
                                    });
                                    $('.Txt_FinanceAdharcardNo').focus();
                                }
                            }
                            else if ($('.Txt_FinancePanCardNo').val() != '' && $('.Txt_FinancePanCardNo').val().length == 10) { } else {
                                check = false;
                                $('.Txt_FinancePanCardNo').tooltip({
                                    placement: "top",
                                    title: "Enter Correct Finance Pancard Number",
                                    trigger: "focus"
                                });
                                $('.Txt_FinancePanCardNo').focus();
                            }
                        }
                        else if ($('.Txt_LogisticAdharcardNo').val() != '' && $('.Txt_LogisticAdharcardNo').val().length == 12) {
                        }
                        else {
                            check = false;
                            $('.Txt_LogisticAdharcardNo').tooltip({
                                placement: "top",
                                title: "Enter Correct Logistic Adhaarcard Number",
                                trigger: "focus"
                            });
                            $('.Txt_LogisticAdharcardNo').focus();
                        }
                    }
                    else if ($('.Txt_LogisticPanCardNo').val() != '' && $('.Txt_LogisticPanCardNo').val().length == 10) { }
                    else {
                        check = false;
                        $('.Txt_LogisticPanCardNo').tooltip({
                            placement: "top",
                            title: "Enter Correct Logistic Pancard Number",
                            trigger: "focus"
                        });
                        $('.Txt_LogisticPanCardNo').focus();
                    }
                }
                else if ($('.Txt_CustomerCIN').val() != '' && $('.Txt_CustomerCIN').val().length == 21) {
                    if ($('.Txt_LogisticPanCardNo').val() == '') {
                        if ($('.Txt_LogisticAdharcardNo').val() == '') {
                            if ($('.Txt_FinancePanCardNo').val() == '') {
                                if ($('.Txt_FinanceAdharcardNo').val() == '') {
                                    if ($('.Txt_DirectorsPanCardNo').val() == '') {
                                        if ($('.Txt_DirectorAdharcardNo').val() == '') {

                                        }
                                        else if ($('.Txt_DirectorAdharcardNo').val() != '' && $('.Txt_DirectorAdharcardNo').val().length == 12) {

                                        } else {
                                            check = false;
                                            $('.Txt_DirectorAdharcardNo').tooltip({
                                                placement: "top",
                                                title: "Enter Correct Director Adhaarcard Number",
                                                trigger: "focus"
                                            });
                                            $('.Txt_DirectorAdharcardNo').focus();
                                        }
                                    }
                                    else if ($('.Txt_DirectorsPanCardNo').val() != '' && $('.Txt_DirectorsPanCardNo').val().length == 10) {
                                    } else {
                                        check = false;
                                        $('.Txt_DirectorsPanCardNo').tooltip({
                                            placement: "top",
                                            title: "Enter Correct Director Pancard Number",
                                            trigger: "focus"
                                        });
                                        $('.Txt_DirectorsPanCardNo').focus();
                                    }
                                }
                                else if ($('.Txt_FinanceAdharcardNo').val() != '' && $('.Txt_FinanceAdharcardNo').val().length == 12) {
                                } else {
                                    check = false;
                                    $('.Txt_FinanceAdharcardNo').tooltip({
                                        placement: "top",
                                        title: "Enter Correct Finance Adhaarcard Number",
                                        trigger: "focus"
                                    });
                                    $('.Txt_FinanceAdharcardNo').focus();
                                }
                            }
                            else if ($('.Txt_FinancePanCardNo').val() != '' && $('.Txt_FinancePanCardNo').val().length == 10) { } else {
                                check = false;
                                $('.Txt_FinancePanCardNo').tooltip({
                                    placement: "top",
                                    title: "Enter Correct Finance Pancard Number",
                                    trigger: "focus"
                                });
                                $('.Txt_FinancePanCardNo').focus();
                            }
                        }
                        else if ($('.Txt_LogisticAdharcardNo').val() != '' && $('.Txt_LogisticAdharcardNo').val().length == 12) {
                        }
                        else {
                            check = false;
                            $('.Txt_LogisticAdharcardNo').tooltip({
                                placement: "top",
                                title: "Enter Correct Logistic Adhaarcard Number",
                                trigger: "focus"
                            });
                            $('.Txt_LogisticAdharcardNo').focus();
                        }
                    }
                    else if ($('.Txt_LogisticPanCardNo').val() != '' && $('.Txt_LogisticPanCardNo').val().length == 10) {
                        if ($('.Txt_LogisticAdharcardNo').val() == '') {
                            if ($('.Txt_FinancePanCardNo').val() == '') {
                                if ($('.Txt_FinanceAdharcardNo').val() == '') {
                                    if ($('.Txt_DirectorsPanCardNo').val() == '') {
                                        if ($('.Txt_DirectorAdharcardNo').val() == '') {

                                        }
                                        else if ($('.Txt_DirectorAdharcardNo').val() != '' && $('.Txt_DirectorAdharcardNo').val().length == 12) {

                                        } else {
                                            check = false;
                                            $('.Txt_DirectorAdharcardNo').tooltip({
                                                placement: "top",
                                                title: "Enter Correct Director Adhaarcard Number",
                                                trigger: "focus"
                                            });
                                            $('.Txt_DirectorAdharcardNo').focus();
                                        }
                                    }
                                    else if ($('.Txt_DirectorsPanCardNo').val() != '' && $('.Txt_DirectorsPanCardNo').val().length == 10) {
                                    } else {
                                        check = false;
                                        $('.Txt_DirectorsPanCardNo').tooltip({
                                            placement: "top",
                                            title: "Enter Correct Director Pancard Number",
                                            trigger: "focus"
                                        });
                                        $('.Txt_DirectorsPanCardNo').focus();
                                    }
                                }
                                else if ($('.Txt_FinanceAdharcardNo').val() != '' && $('.Txt_FinanceAdharcardNo').val().length == 12) {
                                } else {
                                    check = false;
                                    $('.Txt_FinanceAdharcardNo').tooltip({
                                        placement: "top",
                                        title: "Enter Correct Finance Adhaarcard Number",
                                        trigger: "focus"
                                    });
                                    $('.Txt_FinanceAdharcardNo').focus();
                                }
                            }
                            else if ($('.Txt_FinancePanCardNo').val() != '' && $('.Txt_FinancePanCardNo').val().length == 10) { } else {
                                check = false;
                                $('.Txt_FinancePanCardNo').tooltip({
                                    placement: "top",
                                    title: "Enter Correct Finance Pancard Number",
                                    trigger: "focus"
                                });
                                $('.Txt_FinancePanCardNo').focus();
                            }
                        }
                        else if ($('.Txt_LogisticAdharcardNo').val() != '' && $('.Txt_LogisticAdharcardNo').val().length == 12) {
                            if ($('.Txt_FinancePanCardNo').val() == '') {
                                if ($('.Txt_FinanceAdharcardNo').val() == '') {
                                    if ($('.Txt_DirectorsPanCardNo').val() == '') {
                                        if ($('.Txt_DirectorAdharcardNo').val() == '') {

                                        }
                                        else if ($('.Txt_DirectorAdharcardNo').val() != '' && $('.Txt_DirectorAdharcardNo').val().length == 12) {

                                        } else {
                                            check = false;
                                            $('.Txt_DirectorAdharcardNo').tooltip({
                                                placement: "top",
                                                title: "Enter Correct Director Adhaarcard Number",
                                                trigger: "focus"
                                            });
                                            $('.Txt_DirectorAdharcardNo').focus();
                                        }
                                    }
                                    else if ($('.Txt_DirectorsPanCardNo').val() != '' && $('.Txt_DirectorsPanCardNo').val().length == 10) {
                                    } else {
                                        check = false;
                                        $('.Txt_DirectorsPanCardNo').tooltip({
                                            placement: "top",
                                            title: "Enter Correct Director Pancard Number",
                                            trigger: "focus"
                                        });
                                        $('.Txt_DirectorsPanCardNo').focus();
                                    }
                                }
                                else if ($('.Txt_FinanceAdharcardNo').val() != '' && $('.Txt_FinanceAdharcardNo').val().length == 12) {
                                } else {
                                    check = false;
                                    $('.Txt_FinanceAdharcardNo').tooltip({
                                        placement: "top",
                                        title: "Enter Correct Finance Adhaarcard Number",
                                        trigger: "focus"
                                    });
                                    $('.Txt_FinanceAdharcardNo').focus();
                                }
                            }
                            else if ($('.Txt_FinancePanCardNo').val() != '' && $('.Txt_FinancePanCardNo').val().length == 10) {
                                if ($('.Txt_FinanceAdharcardNo').val() == '') {
                                    if ($('.Txt_DirectorsPanCardNo').val() == '') {
                                        if ($('.Txt_DirectorAdharcardNo').val() == '') {

                                        }
                                        else if ($('.Txt_DirectorAdharcardNo').val() != '' && $('.Txt_DirectorAdharcardNo').val().length == 12) {

                                        } else {
                                            check = false;
                                            $('.Txt_DirectorAdharcardNo').tooltip({
                                                placement: "top",
                                                title: "Enter Correct Director Adhaarcard Number",
                                                trigger: "focus"
                                            });
                                            $('.Txt_DirectorAdharcardNo').focus();
                                        }
                                    }
                                    else if ($('.Txt_DirectorsPanCardNo').val() != '' && $('.Txt_DirectorsPanCardNo').val().length == 10) {
                                    } else {
                                        check = false;
                                        $('.Txt_DirectorsPanCardNo').tooltip({
                                            placement: "top",
                                            title: "Enter Correct Director Pancard Number",
                                            trigger: "focus"
                                        });
                                        $('.Txt_DirectorsPanCardNo').focus();
                                    }
                                }
                                else if ($('.Txt_FinanceAdharcardNo').val() != '' && $('.Txt_FinanceAdharcardNo').val().length == 12) {
                                    if ($('.Txt_DirectorsPanCardNo').val() == '') {
                                        if ($('.Txt_DirectorAdharcardNo').val() == '') {

                                        }
                                        else if ($('.Txt_DirectorAdharcardNo').val() != '' && $('.Txt_DirectorAdharcardNo').val().length == 12) {

                                        } else {
                                            check = false;
                                            $('.Txt_DirectorAdharcardNo').tooltip({
                                                placement: "top",
                                                title: "Enter Correct Director Adhaarcard Number",
                                                trigger: "focus"
                                            });
                                            $('.Txt_DirectorAdharcardNo').focus();
                                        }
                                    }
                                    else if ($('.Txt_DirectorsPanCardNo').val() != '' && $('.Txt_DirectorsPanCardNo').val().length == 10) {
                                        if ($('.Txt_DirectorAdharcardNo').val() == '') {

                                        }
                                        else if ($('.Txt_DirectorAdharcardNo').val() != '' && $('.Txt_DirectorAdharcardNo').val().length == 12) {

                                        } else {
                                            check = false;
                                            $('.Txt_DirectorAdharcardNo').tooltip({
                                                placement: "top",
                                                title: "Enter Correct Director Adhaarcard Number",
                                                trigger: "focus"
                                            });
                                            $('.Txt_DirectorAdharcardNo').focus();
                                        }
                                    } else {
                                        check = false;
                                        $('.Txt_DirectorsPanCardNo').tooltip({
                                            placement: "top",
                                            title: "Enter Correct Director Pancard Number",
                                            trigger: "focus"
                                        });
                                        $('.Txt_DirectorsPanCardNo').focus();
                                    }
                                } else {
                                    check = false;
                                    $('.Txt_FinanceAdharcardNo').tooltip({
                                        placement: "top",
                                        title: "Enter Correct Finance Adhaarcard Number",
                                        trigger: "focus"
                                    });
                                    $('.Txt_FinanceAdharcardNo').focus();
                                }
                            } else {
                                check = false;
                                $('.Txt_FinancePanCardNo').tooltip({
                                    placement: "top",
                                    title: "Enter Correct Finance Pancard Number",
                                    trigger: "focus"
                                });
                                $('.Txt_FinancePanCardNo').focus();
                            }
                        }
                        else {
                            check = false;
                            $('.Txt_LogisticAdharcardNo').tooltip({
                                placement: "top",
                                title: "Enter Correct Logistic Adhaarcard Number",
                                trigger: "focus"
                            });
                            $('.Txt_LogisticAdharcardNo').focus();
                        }
                    }
                    else {
                        check = false;
                        $('.Txt_LogisticPanCardNo').tooltip({
                            placement: "top",
                            title: "Enter Correct Logistic Pancard Number",
                            trigger: "focus"
                        });
                        $('.Txt_LogisticPanCardNo').focus();
                    }
                } else {
                    check = false;
                    $('.Txt_CustomerCIN').tooltip({
                        placement: "top",
                        title: "Enter Correct Customer CIN Number",
                        trigger: "focus"
                    });
                    $('.Txt_CustomerCIN').focus();
                }
            }
            else {
                check = false;
                $('.Txt_CustomerGSTCertificates').tooltip({
                    placement: "top",
                    title: "Enter Correct Customer GST Number",
                    trigger: "focus"
                });
                $('.Txt_CustomerGSTCertificates').focus();
            }
        }
        else {
            check = false;
            $('.Txt_AdharcardNo').tooltip({
                placement: "top",
                title: "Enter Correct Customer Aadharcard Number",
                trigger: "focus"
            });
            $('.Txt_AdharcardNo').focus();
        }
    }
    else {
        check = false;
        $('.Txt_PanCardNo').tooltip({
            placement: "top",
            title: "Enter Correct Customer Pancard Number",
            trigger: "focus"
        });
        $('.Txt_PanCardNo').focus();
    }

    if (!check) {
        return false;
    }
    else {
        $('[id*=HiddenField_Submit1]').val("1");
        console.log($('[id*=HiddenField_Submit1]').val());

        return true;

    }
}

//if ($('.Txt_PanCardNo').val() != '' && $('.Txt_PanCardNo').val().length == 10) {
//    if ($('.Txt_AdharcardNo').val() != '' && $('.Txt_AdharcardNo').val().length == 12) {
//        if ($('.Txt_CustomerGSTCertificates').val() != '' && $('.Txt_CustomerGSTCertificates').val().length == 15) {
//            if ($('.Txt_CustomerCIN').val() != '' && $('.Txt_CustomerCIN').val().length == 21) {
//                if ($('.Txt_LogisticPanCardNo').val() != '' && $('.Txt_LogisticPanCardNo').val().length == 10) {
//                    if ($('.Txt_LogisticAdharcardNo').val() != '' && $('.Txt_LogisticAdharcardNo').val().length == 12) {
//                        if ($('.Txt_FinancePanCardNo').val() != '' && $('.Txt_FinancePanCardNo').val().length == 10) {
//                            if ($('.Txt_FinanceAdharcardNo').val() != '' && $('.Txt_FinanceAdharcardNo').val().length == 12) {
//                                if ($('.Txt_DirectorsPanCardNo').val() != '' && $('.Txt_DirectorsPanCardNo').val().length == 10) {
//                                    if ($('.Txt_DirectorAdharcardNo').val() != '' && $('.Txt_DirectorAdharcardNo').val().length == 12) {

//                                    } else {
//                                        check = false;
//                                        $('.Txt_DirectorAdharcardNo').tooltip({
//                                            placement: "top",
//                                            title: "Enter Adhaarcard Number",
//                                            trigger: "focus"
//                                        });
//                                        $('.Txt_DirectorAdharcardNo').focus();
//                                    }
//                                } else {
//                                    check = false;
//                                    $('.Txt_DirectorsPanCardNo').tooltip({
//                                        placement: "top",
//                                        title: "Enter Pancard Number",
//                                        trigger: "focus"
//                                    });
//                                    $('.Txt_DirectorsPanCardNo').focus();
//                                }
//                            } else {
//                                check = false;
//                                $('.Txt_FinanceAdharcardNo').tooltip({
//                                    placement: "top",
//                                    title: "Enter Adhaarcard Number",
//                                    trigger: "focus"
//                                });
//                                $('.Txt_FinanceAdharcardNo').focus();
//                            }
//                        } else {
//                            check = false;
//                            $('.Txt_FinancePanCardNo').tooltip({
//                                placement: "top",
//                                title: "Enter Pancard Number",
//                                trigger: "focus"
//                            });
//                            $('.Txt_FinancePanCardNo').focus();
//                        }
//                    } else {
//                        check = false;
//                        $('.Txt_LogisticAdharcardNo').tooltip({
//                            placement: "top",
//                            title: "Enter Adhaarcard Number",
//                            trigger: "focus"
//                        });
//                        $('.Txt_LogisticAdharcardNo').focus();
//                    }
//                } else {
//                    check = false;
//                    $('.Txt_LogisticPanCardNo').tooltip({
//                        placement: "top",
//                        title: "Enter Pancard Number",
//                        trigger: "focus"
//                    });
//                    $('.Txt_LogisticPanCardNo').focus();
//                }
//            } else {
//                check = false;
//                $('.Txt_CustomerCIN').tooltip({
//                    placement: "top",
//                    title: "Enter CIN Number",
//                    trigger: "focus"
//                });
//                $('.Txt_CustomerCIN').focus();
//            }
//        } else {
//            check = false;
//            $('.Txt_CustomerGSTCertificates').tooltip({
//                placement: "top",
//                title: "Enter GST Number",
//                trigger: "focus"
//            });
//            $('.Txt_CustomerGSTCertificates').focus();
//        }
//    } else {
//        check = false;
//        $('.Txt_AdharcardNo').tooltip({
//            placement: "top",
//            title: "Enter Aadharcard Number",
//            trigger: "focus"
//        });
//        $('.Txt_AdharcardNo').focus();
//    }

//} else {
//    check = false;
//    $('.Txt_PanCardNo').tooltip({
//        placement: "top",
//        title: "Enter Pancard Number",
//        trigger: "focus"
//    });
//    $('.Txt_PanCardNo').focus();
//}

/*Validation of Sales Person Details*/
function validateSalesPersonDetails() {
    var check = true;
    if ($('.Txt_SalespersonName').val() != 'SELECT') {
        if ($('.Txt_SalesContactNo').val() != 'AUTO') {
            if ($('.Txt_SalesEmailId').val() != 'AUTO') {
                if ($('.Txt_SalesTerrioritryOfWork').val() != 'AUTO') {

                } else {
                    check = false;
                    $('.Txt_SalesTerrioritryOfWork').tooltip({
                        placement: "top",
                        title: "Contact To branch",
                        trigger: "focus"
                    });
                    $('.Txt_SalesTerrioritryOfWork').focus();
                }

            } else {
                check = false;
                $('.Txt_SalesEmailId').tooltip({
                    placement: "top",
                    title: "Contact To branch",
                    trigger: "focus"
                });
                $('.Txt_SalesEmailId').focus();
            }
        } else {
            check = false;
            $('.Txt_SalesContactNo').tooltip({
                placement: "top",
                title: "Contact To branch",
                trigger: "focus"
            });
            $('.Txt_SalesContactNo').focus();
        }
    }
    else {
        check = false;
        $('.Txt_SalespersonName').tooltip({
            placement: "top",
            title: "Select Sales Person  Name",
            trigger: "focus"
        });
        $('.Txt_SalespersonName').focus();
    }
    if (!check) {
        return false;
    }
    else {
        $('[id*=HiddenField_Tab2Save]').val("1");
        console.log($('[id*=HiddenField_Tab2Save]').val());
        return true;
    }
}
/*
 //if ($('.Txt_SalesDesignation').val() != '') {
      //} else {
                //    check = false;
                //    $('.Txt_SalesDesignation').tooltip({
                //        placement: "top",
                //        title: "Contact To branch",
                //        trigger: "focus"
                //    });
                //    $('.Txt_SalesDesignation').focus();
                //}
*/
/*Validation of Logistic Person Details*/
function validateLogisticPersonDetails() {
    var check = true;
    var CompEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

    if ($('.Txt_LogisticPersonName').val() != '') {
        if ($('.Txt_LogisticContactNo').val() != '' && $('.Txt_LogisticContactNo').val().length == 10) {
            if ($('.Txt_LogisticPersonEmailId').val() == '') {
                //if ($('.Txt_LogisticPersonDesignation').val() != '') {

                //} else {
                //    check = false;
                //    $('.Txt_LogisticPersonDesignation').tooltip({
                //        placement: "top",
                //        title: "Enter Designation",
                //        trigger: "focus"
                //    });
                //    $('.Txt_LogisticPersonDesignation').focus();
                //}
            } else if ($('.Txt_LogisticPersonEmailId').val() != '' && CompEmail.test($('.Txt_LogisticPersonEmailId').val())) {
                //if ($('.Txt_LogisticPersonDesignation').val() != '') {

                //} else {
                //    check = false;
                //    $('.Txt_LogisticPersonDesignation').tooltip({
                //        placement: "top",
                //        title: "Enter Designation",
                //        trigger: "focus"
                //    });
                //    $('.Txt_LogisticPersonDesignation').focus();
                //}
            } else {
                check = false;
                $('.Txt_LogisticPersonEmailId').tooltip({
                    placement: "top",
                    title: "Enter Logistic Person Valid Email Id",
                    trigger: "focus"
                });
                $('.Txt_LogisticPersonEmailId').focus();
            }
        } else {
            check = false;
            $('.Txt_LogisticContactNo').tooltip({
                placement: "top",
                title: "Enter Logistic Person Contact Number",
                trigger: "focus"
            });
            $('.Txt_LogisticContactNo').focus();
        }
    } else {
        check = false;
        $('.Txt_LogisticPersonName').tooltip({
            placement: "top",
            title: "Enter Logistic Person Name",
            trigger: "focus"
        });
        $('.Txt_LogisticPersonName').focus();
    }
    if (!check) {
        return false;
    }
    else {

        $('[id*=HiddenField_Tab3Save]').val("1");
        console.log($('[id*=HiddenField_Tab3Save]').val());
        return true;
    }
}
/*  //if ($('.Txt_LogisticPanCardNo').val() != '' && $('.Txt_LogisticPanCardNo').val().length == 10) {
                    //    if ($('.Txt_LogisticAdharcardNo').val() != '' && $('.Txt_LogisticAdharcardNo').val().length == 12) {

                    //    } else {
                    //        check = false;
                    //        $('.Txt_LogisticAdharcardNo').tooltip({
                    //            placement: "top",
                    //            title: "Enter Adhaarcard Number",
                    //            trigger: "focus"
                    //        });
                    //        $('.Txt_LogisticAdharcardNo').focus();
                    //    }
                    //} else {
                    //    check = false;
                    //    $('.Txt_LogisticPanCardNo').tooltip({
                    //        placement: "top",
                    //        title: "Enter Pancard Number",
                    //        trigger: "focus"
                    //    });
                    //    $('.Txt_LogisticPanCardNo').focus();
                    //}*/
/*Validation of Finance Person Details*/
function validateFinancePersonDetails() {
    var check = true;
    var CompEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

    if ($('.Txt_FPersonName').val() != '') {
        if ($('.Txt_FContactNo').val() != '' && $('.Txt_FContactNo').val().length == 10) {
            if ($('.Txt_FEmailId').val() == '') {
                //if ($('.Txt_FDesignation').val() != '') {

                //} else {
                //    check = false;
                //    $('.Txt_FDesignation').tooltip({
                //        placement: "top",
                //        title: "Enter Designation",
                //        trigger: "focus"
                //    });
                //    $('.Txt_FDesignation').focus();
                //}
            } else if ($('.Txt_FEmailId').val() != '' && CompEmail.test($('.Txt_FEmailId').val())) {
                //if ($('.Txt_FDesignation').val() != '') {

                //} else {
                //    check = false;
                //    $('.Txt_FDesignation').tooltip({
                //        placement: "top",
                //        title: "Enter Designation",
                //        trigger: "focus"
                //    });
                //    $('.Txt_FDesignation').focus();
                //}
            }
            else {
                check = false;
                $('.Txt_FEmailId').tooltip({
                    placement: "top",
                    title: "Enter Finance Person Valid Email Id",
                    trigger: "focus"
                });
                $('.Txt_FEmailId').focus();
            }
        } else {
            check = false;
            $('.Txt_FContactNo').tooltip({
                placement: "top",
                title: "Enter Finance Person Contact Number",
                trigger: "focus"
            });
            $('.Txt_FContactNo').focus();
        }
    } else {
        check = false;
        $('.Txt_FPersonName').tooltip({
            placement: "top",
            title: "Enter Finance Person Name",
            trigger: "focus"
        });
        $('.Txt_FPersonName').focus();
    }
    if (!check) {
        return false;
    }
    else {

        $('[id*=HiddenField_Tab4Save]').val("1");
        console.log($('[id*=HiddenField_Tab4Save]').val());
        return true;
    }
}
/*Validation of Directors Person Details*/
function validateDirectorPersonDetails() {
    var check = true;
    var CompEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

    if ($('.Txt_DirectorperonName').val() != '') {
        if ($('.Txt_DirectorContactNo').val() != '' && $('.Txt_DirectorContactNo').val().length == 10) {
            if ($('.Txt_DirectorEmailIds').val() == '') {
                //if ($('.Txt_DirectorDesignation').val() != '') {

                //} else {
                //    check = false;
                //    $('.Txt_DirectorDesignation').tooltip({
                //        placement: "top",
                //        title: "Enter Designation",
                //        trigger: "focus"
                //    });
                //    $('.Txt_DirectorDesignation').focus();
                //}
            } else if ($('.Txt_DirectorEmailIds').val() != '' && CompEmail.test($('.Txt_DirectorEmailIds').val())) {
                //if ($('.Txt_DirectorDesignation').val() != '') {

                //} else {
                //    check = false;
                //    $('.Txt_DirectorDesignation').tooltip({
                //        placement: "top",
                //        title: "Enter Designation",
                //        trigger: "focus"
                //    });
                //    $('.Txt_DirectorDesignation').focus();
                //}
            } else {
                check = false;
                $('.Txt_DirectorEmailIds').tooltip({
                    placement: "top",
                    title: "Enter Director Person Valid Email Id",
                    trigger: "focus"
                });
                $('.Txt_DirectorEmailIds').focus();
            }
        } else {
            check = false;
            $('.Txt_DirectorContactNo').tooltip({
                placement: "top",
                title: "Enter Director Person Contact Number",
                trigger: "focus"
            });
            $('.Txt_DirectorContactNo').focus();
        }
    } else {
        check = false;
        $('.Txt_DirectorperonName').tooltip({
            placement: "top",
            title: "Enter Director Person Name",
            trigger: "focus"
        });
        $('.Txt_DirectorperonName').focus();
    }
    if (!check) {
        return false;
    }
    else {
        $('[id*=HiddenField_Tab5Save]').val("1");
        console.log($('[id*=HiddenField_Tab5Save]').val());
        return true;
    }
}
/*Popup Area Details Validation*/
function validatePopupAreaDetails() {
    var check = true;
    if ($('.Txt_popArea').val() != '') {

    } else {
        check = false;
        $('.Txt_popArea').tooltip({
            placement: "top",
            title: "Enter Area Name",
            trigger: "focus"
        });
        $('.Txt_popArea').focus();
    }
    if (!check) {
        return false;
    }
    else {

        $('[id*=HiddenField_Btn_PopupAreaSubmit]').val("1");
        console.log($('[id*=HiddenField_Btn_PopupAreaSubmit]').val());
        return true;
    }

    /* if ($('.Ddl_popPincode option:selected').text() != 'Select...') {
            if ($('.Ddl_popState option:selected').text() != 'Select...') {
                if ($('.Ddl_popDistrict option:selected').text() != 'Select...') {
                    if ($('.Ddl_popCity option:selected').text() != 'Select...') {

                    } else {
                        check = false;
                        $('.Ddl_popCity').tooltip({
                            placement: "top",
                            title: "Select City",
                            trigger: "focus"
                        });
                        $('.Ddl_popCity').focus();
                    }
                } else {
                    check = false;
                    $('.Ddl_popDistrict').tooltip({
                        placement: "top",
                        title: "select District",
                        trigger: "focus"
                    });
                    $('.Ddl_popDistrict').focus();
                }
            } else {
                check = false;
                $('.Ddl_popState').tooltip({
                    placement: "top",
                    title: "Select State",
                    trigger: "focus"
                });
                $('.Ddl_popState').focus();
            }
        } else {
            check = false;
            $('.Ddl_popPincode').tooltip({
                placement: "top",
                title: "Select Pincode",
                trigger: "focus"
            });
            $('.Ddl_popPincode').focus();
        }*/
}
/* Check Numbers Only*/
$('.FirstNotZero').keypress(function (e) {
    if (this.value.length == 0 && e.which == 48) {
        return false;
    }

    //// attach the event binding function to every partial update
    //Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function(evt, args) {
    //    bindEvents();
});

$('.SPACE').on('keypress', function (e) {
    if (e.which === 32 && !this.value.length)
        e.preventDefault();
});

/*function validateNumericValue(key) {
    var keycode = (key.which) ? key.which : key.keyCode;

    if (!(keycode >= 48 && keycode <= 57)) {
        return false;
    }
    else {

        return true;
    }
}*/

function checkNumAlpha() {

    if (((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8 || event.keyCode == 32)) {
        return true;
    }
    else {
        return false;
    }
}

function checkAlphaNumeric() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || (event.keyCode > 47 && event.keyCode < 58) || event.keyCode == 8) {
        return true;
    }
    else {
        return false;
    }
}

/*validate Pancard*/
function validatePancardNum() {
    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 47 && event.keyCode < 58) || event.keyCode == 8) {
        return true;
    }
    else {
        return false;
    }
}

function onlyAlphaValue() {

    if ((event.keyCode > 64 && event.keyCode < 91) || (event.keyCode > 96 && event.keyCode < 123) || event.keyCode == 8 || event.keyCode == 32) {
        return true;
    }
    else {
        return false;
    }
}
function checkEmailId() {

    if (event.keyCode == 32) {
        return false;
    }
    else {
        return true;
    }
}