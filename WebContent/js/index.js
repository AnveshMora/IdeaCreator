// Login/Register form
// Author: Ian Pirro 
//------------------------------------
// Form will change from login to register and visa-versa based
// on if the user is already "registered"
// "Usernames" min-len is 5 chars
//
// Could be annoying... but fun anyways


// These users "already exist"
var users = [
{ name: 'ianpirro' },
{ name: 'joeschmoe' },
{ name: 'superdev' }
]

var loginform = {
  
  init: function() {
    this.bindUserBox();
  },
  
  bindUserBox: function() {
    var result = {};
    
    $(".form").delegate("input[name='un']", 'blur',  function(){
      var $self = $(this);
      
      // this grep would be replaced by $.post tp check db for user
      result = $.grep(users, function(elem, i){  
        return (elem.name == $self.val());
      });
      
      // This would be callback
      if (result.length === 1) {
        if( $("div.login-wrap").hasClass('register')) {
       //   loginform.revertForm();
          return;
        }
        else{
          return;
        }
      }
      
      if( !$("div.login-wrap").hasClass('register') ) {
        if ( $("input[name='un']").val().length > 4 )
        //  loginform.switchForm();
      }

    });
  },
  switchForm: function() {
   
	  console.log("avoiding switching of the form")
	  
  },
  revertForm: function() {
	  console.log("avoiding switching of the form")
  },
  submitForm: function(){
    // ajax to handle register or login
  }
  
} // loginform {}


// Init login form
loginform.init();


// vertical align box   
(function(elem){ 
    elem.css("margin-top", Math.floor( ( $(window).height() / 2 ) - ( elem.height() / 2 ) ) );
}($(".login-wrap")));

$(window).resize(function(){
    $(".login-wrap").css("margin-top", Math.floor( ( $(window).height() / 2 ) - ( $(".login-wrap").height() / 2 ) ) );
  
});