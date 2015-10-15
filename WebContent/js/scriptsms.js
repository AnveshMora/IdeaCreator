
$(function () {
    var user = {},
        flg = {};
    init();
    $('.upload').click(function () {
        if (flg.upd == 0) {
            upd('upload');
            flg.upd = 1
        } else {
            upd('');
            flg.upd = 0
        }
    });
    $('#login').click(function () {
        initub();
        $('#logmsk').fadeIn();
        ub(0)
    });
    $('#logint').click(function () {
        initub();
        if (flg.logt == 0) {
            ub(1);
            flg.logt = 1
        } else {
            ub(0);
            flg.logt = 0
        }
    });
    $("#name").keyup(function () {
        var len = $('#name').val().length;
        if (len > 10 || len == 0) {
            $('#name').css('background', 'rgb(255, 214, 190)');
            blsp();
            if (len > 10) {
                $('#nameal').css('color', 'rgb(255, 57, 19)').text('Phone Number: Too long').fadeIn()
            } else {
                $('#nameal').css('color', 'rgb(255, 57, 19)').text('Enter phone number').fadeIn()
            }
            flg.name = 1
        } else {
            $('#name').css('background', 'rgb(255, 255, 255)');
            flg.name = 0;
            tcheck()
        }
    });
    $("#pass").keyup(function () {
        var len = $('#pass').val().length;
        if (len > 255 || len == 0) {
            $('#pass').css('background', 'rgb(255, 214, 190)');
            blsp();
            if (len != 0) {
                $('#passal').css('color', 'rgb(255, 57, 19)').text('Message: Too long').fadeIn()
            } else {
                $('#passal').css('color', 'rgb(255, 57, 19)').text('Enter Message: Null').fadeIn()
            }
            flg.pass = 1
        } else {
            $('#pass').css('background', 'rgb(255, 255, 255)');
            flg.pass = 0;
            tcheck()
        }
    });

    function tcheck() {
        if (flg.name == 0 && flg.pass == 0) {
            $('#signupb').css('opacity', '1').css('cursor', 'pointer')
        } else {
            blsp()
        }
    }
    $('#signupb').click(function () {
        if (flg.name == 0 && flg.pass == 0) {
            $('#sumsk').fadeIn();
            $('#name, #pass, #logint, #nameal, #passal, #signupb').css('opacity', '0.2');
            $('#close').fadeIn()
        }
    });
    $('#close').click(function () {
        init();
        initub();
        $('#close').hide()
    });

    function init() {
        flg.logt = 0
    }

    function initub() {
        flg.name = -1;
        flg.pass = -1;
        $('#sumsk').hide();
        $('#nameal').hide();
        $('#passal').hide();
        $('#name, #pass, #logint, #nameal, #passal, #signupb').css('opacity', '1');
        $('#name').css('background', 'rgb(255, 255, 255)');
        $('#pass').css('background', 'rgb(255, 255, 255)');
        $('#signupb').css('opacity', '0.2').css('cursor', 'default');
        $('#name, #pass').val('')
    }

    function upd(button) {
        location.hash = button;
        if (flg.upd == 0) {
            $('#drop').fadeIn()
        } else {
            $('#drop').fadeOut()
        }
    }

    function ub(flg) {
        if (flg == 0) {
            $('#signup').text('Sign up').css('background', '#76ABDB');
            $('#signupb').text('Sign up');
            $('#logint').text('Login as an existing user')
        } else {
            $('#signup').text('Login').css('background', '#FFA622');
            $('#signupb').text('Login');
            $('#logint').text('Sign up as a new user')
        }
    }

    function blsp() {
        $('#signupb').css('opacity', '0.2').css('cursor', 'default')
    }
});