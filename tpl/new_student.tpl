%include('header0.tpl')

<style>
form{
  padding: 100px;
  display: flex;
  justify-content: center;
  align-items: center;
}
#sname,
#sroll,
#scon,
#sgender,
#sdob,
#syear,
#sbranch,
#sadd{
  width: 500px;
}

#sname,
#sroll,
#scon,
#sgender,
#sdob,
#syear,
#sbranch{
  height: 50px;
  border-radius: 30px;
}


.containerpage{
  width: 900px;
  border: 1px solid white;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-top: 100px;
  border-radius: 30px;
}
h2{
  font-weight: 600;
}
</style>

<div id='ajax_success'></div>
<br/>
<form id="reg" action="/new_student" method="POST" ><!-- onsubmit=func()-->
  <div class="containerpage">
    <h2>Student Registration</h2>
    <div>
    <label for="sname">Name</label>
    <input class="u-full-width" type="text" id="sname" maxlength="39" name="1"/ placeholder="Enter your name" required>
    </div>

    <div>
    <label for="sroll">Roll no.</label>
    <input class="u-full-width" type="number" id="sroll" min="1" maxlength="10" name="2"/ placeholder="Enter your roll no." required>
    </div>
    
    <div>
    <label for="scon">Contact no.</label>
    <input class="u-full-width" type="tel" id="scon" name="6" pattern="^\d{10}$" maxlength="10" placeholder="Enter your contact no."  style="color:black" required/>
    </div>

    <div>
        <label for="sdob">Date of birth</label>
        <input class="u-full-width" type="date" id="sdob"  name="3"/ placeholder="Enter your date of birth" style="color:black" required>
    </div>

    <div>
        <label for="sgender">Gender</label>
        <select class="u-full-width" id="sgender" name="4" required>
          <option value="f">Female</option>
          <option value="m">Male</option>
        </select>
    </div>

    <div>
        <label for="syear">Year</label>
        <select class="u-full-width" id="syear" name="7" required>
          <option value="1">First</option>
          <option value="2">Second</option>
          <option value="3">Third</option>
          <option value="4">Fourth</option>
        </select>
    </div>

    <div>
        <label for="sbranch">Branch</label>
        <select class="u-full-width" id="sbranch" name="8" required>
            <option value="cse">CSE</option>
          <option value="eee">EE</option>
          <option value="me">ME</option>
          <option value="ce">CE</option>
          <option value="ai">AI</option>
          <option value="ec">EC</option>
        <option value="bt">BT</option>
          <option value="as">AS</option>
          <option value="iem">IEM</option>
          
        </select>
    </div>

    <div>
      <label for="sadd">Address</label>
    <textarea class="u-full-width" id="sadd" name="5" maxlength="190" required></textarea>
    </div>




    <!-- <div class="row">
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
    </div> -->

    <input class="button-primary" type="submit" name="save" value="save">
  </div>
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
<!--       <form>
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
</form> -->



    

<!-- End Document
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
</body>


</html>