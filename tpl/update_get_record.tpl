%x=(lolcat!='0')*1
%y='header{}'.format(x)
% include(y)
<style>
  /* Styles specific to search_student.tpl */
  .row {
    margin-bottom: 2rem;
    display: flex;
    flex-wrap: wrap;
    gap: 2rem;
  }

  .four.columns {
    flex: 1;
    min-width: 300px;
    background: rgba(255, 255, 255, 0.1);
    padding: 2rem;
    border-radius: 8px;
    backdrop-filter: blur(5px);
  }

  /* Form element styles */
  .search-form input[type="text"],
  .search-form input[type="number"],
  .search-form select,
  .search-form textarea {
    width: 100%;
    min-height: 38px;
    padding: 6px 10px;
    background-color: rgba(255, 255, 255, 0.9);
    border: 1px solid #D1D1D1;
    border-radius: 4px;
    box-shadow: none;
    box-sizing: border-box;
    margin-bottom: 1.5rem;
  }

  #ajax_success {
    margin-top: 2rem;
    padding: 2rem;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 8px;
    backdrop-filter: blur(5px);
    color: #fff;
  }

  @media (max-width: 768px) {
    .row {
      flex-direction: column;
      gap: 1rem;
    }

    .four.columns {
      min-width: 100%;
      margin-bottom: 1rem;
    }
  }
</style>

<div class="row">

<div class="four columns">
<form id="exit" action="/update_gate_record" method="POST">
  <label for="sroll">Roll no.</label>
  <input class="u-full-width" type="number" id="sroll" max="999999999" name="1"/>

  <label for="purp">Purpose</label>
  <textarea class="u-full-width" id="purp" name="2" maxlength="190"></textarea>
  <input class="u-full-width" type="text" id="3sname" maxlength="39" name="10" value="1" style="display: none;" />

  <input class="button-primary" type="submit" name="search" value="Add exit record">

</form>
</div>
<div class="four columns">
<form id="entry" action="/update_gate_record" method="POST">
  <label for="sroll">Roll no.</label>
  <input class="u-full-width" type="number" id="sroll" max="999999999" name="1"/>
  <input class="u-full-width" type="text" id="3sname" maxlength="39" name="10" value="2" style="display: none;" />

  

  <input class="button-primary" type="submit" name="search" value="Entry">

</form>
</div>
<div class="four columns">
<form id="show_it" action="/update_gate_record" method="POST">
<label for="croll">Roll no.</label>
      <select class="u-full-width" id="croll" name="5">
        <option value="0">Any</option>
        <option value="1">Specific</option>
      </select>
      
  <input class="u-full-width" type="number"  placeholder="123456789" id="ssroll" max="999999999" name="7" style="display: none;"/>
      
      

  <label for="cvname" >Student status</label>
      <select class="u-full-width" id="cvstatus" name="9">
        <option value="0">Any</option>
        <option value="1">Currently Outside campus</option>
      </select>
      <input class="u-full-width" type="text" id="3sname" maxlength="39" name="10" value="3" style="display: none;" />
      <input class="button-primary" type="submit" name="search" value="Search">


  
  

  

  
</form>
</div>

</div>
<div id='ajax_success' class="u-full-width"></div>

<script>
        $(document).ready(function() {
            $("#croll").on('change', function(){
                $('#ssroll').toggle();
                
            });   
        });
   </script>

<script type="text/javascript">
    var frm3 = $('#show_it');

    frm3.submit(function (e) {

        e.preventDefault();

        $.ajax({
            type: frm3.attr('method'),
            url: frm3.attr('action'),
            data: frm3.serialize(),
            success: function (data) {

              
                var output = data;
                document.getElementById("ajax_success").innerHTML =  output ;
              
$('html, body').animate({
    scrollTop: ($("#navid").offset().top ) 
}, 'slow');

                console.log('Submission was successful.');
                console.log(data);
            },
            error: function (data) {
              alert("error");
                console.log('An error occurred.');
                console.log(data);
            },
        });

    });
</script>


<script type="text/javascript">
    var frm = $('#exit');

    frm.submit(function (e) {

        e.preventDefault();

        $.ajax({
            type: frm.attr('method'),
            url: frm.attr('action'),
            data: frm.serialize(),
            success: function (data) {

              
                var output = data;
                document.getElementById("ajax_success").innerHTML =  output ;
              
$('html, body').animate({
    scrollTop: ($("#navid").offset().top ) 
}, 'slow');

                console.log('Submission was successful.');
                console.log(data);
            },
            error: function (data) {
              alert("error");
                console.log('An error occurred.');
                console.log(data);
            },
        });

    });
</script>
<script type="text/javascript">
    var frm2 = $('#entry');

    frm2.submit(function (e) {

        e.preventDefault();

        $.ajax({
            type: frm2.attr('method'),
            url: frm2.attr('action'),
            data: frm2.serialize(),
            success: function (data) {

              
                var output = data;
                document.getElementById("ajax_success").innerHTML =  output ;

              $('html, body').animate({
    scrollTop: ($("#navid").offset().top ) 
}, 'slow');


                console.log('Submission was successful.');
                console.log(data);
            },
            error: function (data) {
              alert("error");
                console.log('An error occurred.');
                console.log(data);
            },
        });

    });
</script>

<!--
<form id="reg" action="/new_student" method="POST" ><!- - onsubmit=func()- ->
  <label for="sname">Name</label>
  <input class="u-full-width" type="text" id="sname" maxlength="39" name="1"/>

  <div class="row">
    <div class="six columns">
      <label for="sroll">Roll no.</label>
      <input class="u-full-width" type="number" id="sroll" maxlength="10" name="2"/>
    </div>
    <div class="six columns">
      <label for="scon">Contact no.</label>
      <input class="u-full-width" type="number" id="scon" maxlength="10" name="6"/>
    </div>
  </div>

  <div class="row">
    <div class="six columns">
      <label for="sdob">Date of birth</label>
      <input class="u-full-width" type="date" id="sdob"  name="3"/>
    </div>
    <div class="six columns">
      <label for="sgender">Gender</label>
      <select class="u-full-width" id="sgender" name="4">
        <option value="f">Female</option>
        <option value="m">Male</option>
      </select>
    </div>
  </div>

  <label for="sadd">Address</label>
  <textarea class="u-full-width" id="sadd" name="5" maxlength="190"></textarea>

  <div class="row">
    <div class="six columns">
      <label for="syear">Year</label>
      <select class="u-full-width" id="syear" name="7">
        <option value="1">First</option>
        <option value="2">Second</option>
        <option value="3">Third</option>
        <option value="4">Fourth</option>
      </select>
    </div>
    <div class="six columns">
      <label for="sbranch">Branch</label>
      <select class="u-full-width" id="sbranch" name="8">
        <option value="cse">CSE</option>
        <option value="ee">EE</option>
        <option value="me">ME</option>
        <option value="ce">CE</option>
        <option value="mems">MEMS</option>
      </select>
    </div>
  </div>




  <div class="row">
    <div class="four columns">
      <label for="shid">Hostel </label>
      <select class="u-full-width" id="shid" name="9">
          <option value="1">Hall of residences</option>
          <option value="2">Studio Apartments</option>
          <option value="3">Silver Springs</option>
      </select>
    </div>
    <div class="four columns">
      <label for="sflat">Flat no.</label>
      <input class="u-full-width" type="number" id="sflat" min="100" max="999" placeholder="100-999"  name="10"/>
    </div>
    <div class="four columns">
      <label for="sroom">Room </label>
      <select class="u-full-width" id="sroom" name="11">
        <option value="A">A</option>
        <option value="B">B</option>
        <option value="C">C</option>
        <option value="D">D</option>
        <option value="E">E</option>
        <option value="H">H</option>
      </select>
    </div>
  </div>

  <input class="button-primary" type="submit" name="save" value="save">

</form> 


<script type="text/javascript">
    var frm = $('#reg');

    frm.submit(function (e) {

        e.preventDefault();

        $.ajax({
            type: frm.attr('method'),
            url: frm.attr('action'),
            data: frm.serialize(),
            success: function (data) {

              
                var output = data;
                document.getElementById("ajax_success").innerHTML = '<h5><i>' + output + '</i></h5>';
               $('html, body').animate({
    scrollTop: $("#ajax_success").offset().top - ($("#all").offset().top - $("#all").scrollTop()) -100
}, 'slow');


                console.log('Submission was successful.');
                console.log(data);
            },
            error: function (data) {
              alert("error");
                console.log('An error occurred.');
                console.log(data);
            },
        });

    });
</script>
</div>
<!- -       <form>
  <div class="row">
    <div class="six columns">
      <label for="exampleEmailInput">Your email</label>
      <input class="u-full-width" type="email" placeholder="test@mailbox.com" id="exampleEmailInput">
    </div>
    <div class="six columns">
      <label for="exampleRecipientInput">Reason for contacting</label>
      <select class="u-full-width" id="exampleRecipientInput">
        <option value="Option 1">Questions</option>
        <option value="Option 2">Admiration</option>
        <option value="Option 3">Can I get your number?</option>
      </select>
    </div>
  </div>
  <label for="exampleMessage">Message</label>
  <textarea class="u-full-width" placeholder="Hi Dave …" id="exampleMessage"></textarea>
  <label class="example-send-yourself-copy">
    <input type="checkbox">
    <span class="label-body">Send a copy to yourself</span>
  </label>
  <input class="button-primary" type="submit" value="Submit">
</form> - ->-->



    
</div>
<!-- End Document
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
</body>

</html>