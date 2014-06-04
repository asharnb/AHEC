<cfinclude template="../../connection/connection.cfc">
<!--Check if User has been authenticated-->
	
<cfif IsDefined("Session.UserID")>
<cfelse>
	<cflocation url="../../signin.cfm" addtoken="NO">
</cfif>

<cfif StructKeyExists(url,'logoff')>
	<cfset StructClear(Session)>
    <cflocation url="../../signin.cfm" addtoken="NO" >
</cfif>

	
<!--Set Up page level, will be used to determine Forwarding Links-->    
	<cfset This.PageCode = 'hppreceptors'>
<!--Open Navigation-->

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="Ashar Babar Concepts">
  <link rel="shortcut icon" href="../../images/favicon.ico" type="image/png">

  <title>AZAHEC Admin - HP Students</title>

  <link href="../../css/style.default.css" rel="stylesheet">
  <link href="../../css/jquery.datatables.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="http://redbar.arizona.edu/sites/default/files/ua-banner/ua-web-branding/css/ua-web-branding.css">	
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->

</head>

<body>

<!-- Preloader -->
<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>
<!--UA Web Banner -->
<div id="ua-web-branding-banner-v1" class="ua-wrapper bgDark red-grad">
  <a class="ua-home asdf" href="http://arizona.edu" title="The University of Arizona">
    <p>The University of Arizona</p>
  </a>
</div>



<section>
  
    <!-- leftpanel -->
  	<cfinclude template="../../includes/leftpanelnondynamic.cfm">
  <!-- leftpanel -->
  
  <!-- mainpanel start -->
  <div class="mainpanel">
    
	  <!-- header -->
  		<cfinclude template="../../includes/header.cfm">
  	  <!-- header -->
    
        <!-- content dynamic -->
<div class="contentpanel">
<div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">Add New Preceptor</h4>
          <p>Please use this form to add new a new preceptor. Make sure to fill out all the required fields.</p>
        </div>
        <div class="panel-body panel-body-nopadding">
          
          <form class="form-horizontal form-bordered">
            <div class="form-group">
              <label class="col-sm-2 control-label">Title</label>
              <div class="col-sm-4">
                <select class="form-control chosen-select" data-placeholder="Choose a Title...">
                  <option value=""></option>
          <option value="M.D">M.D</option>
           <option value="P.A">P.A</option>
          <option value="N.P">N.P</option>
          <option value="R.N">R.N</option>
          <option value="D.D.S">D.D.S</option>
          <option value="D.O">D.O</option>
          <option value="R.Ph">R.Ph</option>
          <option value="M.S.W">M.S.W</option>
          <option value="Ph.D">Ph.D</option>
          <option value="Pharm.D">Pharm.D</option>
            <option value="R.D">R.D</option>
             <option value="M.P.H">M.P.H</option>
              <option value="F.N.P">F.N.P</option>
                </select>
              </div>

              <label class="col-sm-2 control-label">Speciality</label>
              <div class="col-sm-4">
                <select class="form-control chosen-select" data-placeholder="Choose a Speciality...">
                  <option value=""></option>
			 <option value="1">Advanced Practice Nurse</option>
			 <option value="2">Allied Health</option>
			 <option value="3">Dentistry</option>
			 <option value="4">Medicine</option>
			 <option value="5">Physician Assistant</option>
              <option value="7">Pharmacist</option>
        <option value="8">Public Health</option>
			 <option value="6">Unspecified</option>
                </select>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-2 control-label">First Name</label>
              <div class="col-sm-4">
                <input type="text" placeholder="Enter First Name" class="form-control">
              </div>

              <label class="col-sm-2 control-label">Last Name</label>
              <div class="col-sm-4">
                <input type="text" placeholder="Enter Last Name" class="form-control">
              </div>
            </div>
            
            <div class="form-group">
				  <label class="col-sm-2 control-label" for="Gender">Gender</label>
				  <div class="col-sm-4">
					 <div class="rdio rdio-primary">
                        <input type="radio" name="radio1" value="0" id="radioPrimary11">
                        <label for="radioPrimary11">Male</label>
                    </div>
                      <div class="rdio rdio-primary">
                        <input type="radio" name="radio1" value="0" id="radioPrimary12">
                        <label for="radioPrimary12">Female</label>
                      </div>
				  </div>

				  <label class="col-sm-2 control-label" for="Ethnicity">Ethnicity(Hispanic or Latino)</label>
				  <div class="col-sm-4">
					 <div class="rdio rdio-primary">
                        <input type="radio" name="radio2" value="0" id="radioPrimary21">
                        <label for="radioPrimary21">Yes</label>
                    </div>
                      <div class="rdio rdio-primary">
                        <input type="radio" name="radio2" value="0" id="radioPrimary22">
                        <label for="radioPrimary22">No</label>
                      </div>
				  </div>
			</div>
                
			<div class="form-group">
              <label class="col-sm-2 control-label">Race</label>
              <div class="col-sm-4">
                <select class="form-control chosen-select" data-placeholder="Choose a Race...">
                  <option value=""></option>
                  <option value="United States">American Indian or Alsaka Native</option>
                  <option value="United Kingdom">Asian(Chinese,Filipino,Japanese,Korean,Asian Indian or Thai)</option>
                  <option value="Afghanistan">Other Asian</option>
                  <option value="Aland Islands">Black or African American</option>
                  <option value="Albania">Native Hawaiian/Other Pacific Islander</option>
                  <option value="Algeria">White</option>
                  <option value="American Samoa">Other(Not Reported)</option>
                  <option value="Andorra">More than one race</option>
                </select>
              </div>
            </div>
          </form>
          
        </div><!-- panel-body -->
        
        <div class="panel-footer">
			 <div class="row">
				<div class="col-sm-6 col-sm-offset-3">
				  <button class="btn btn-primary">Submit</button>&nbsp;
				  <button class="btn btn-default">Cancel</button>
				</div>
			 </div>
		  </div><!-- panel-footer -->
        
      </div>
      </div>
        <!-- content dynamic -->
    
    <!-- contentpanel -->
    
  </div>
  <!-- mainpanel end -->
  
  <div class="rightpanel">
    <!-- Nav tabs -->
    <ul class="nav nav-tabs nav-justified">
        <li class="active"><a href="#rp-alluser" data-toggle="tab"><i class="fa fa-users"></i></a></li>
        <li><a href="#rp-favorites" data-toggle="tab"><i class="fa fa-heart"></i></a></li>
        <li><a href="#rp-history" data-toggle="tab"><i class="fa fa-clock-o"></i></a></li>
        <li><a href="#rp-settings" data-toggle="tab"><i class="fa fa-gear"></i></a></li>
    </ul>
        
    <!-- Tab panes -->
    <div class="tab-content">
        <div class="tab-pane active" id="rp-alluser">
            <h5 class="sidebartitle">Online Users</h5>
            <ul class="chatuserlist">
                <li class="online">

            </ul>
            
            <div class="mb30"></div>
            
            <h5 class="sidebartitle">Offline Users</h5>
            <ul class="chatuserlist">
                <li>
                    <div class="media">
                        <a href="#" class="pull-left media-thumb">
                            <img alt="" src="../../images/photos/user5.png" class="media-object">
                        </a>
                        <div class="media-body">
                            <strong>Ashar Babar</strong>
                            <small>Tucson, AZ</small>
                        </div>
                    </div><!-- media -->
                </li>

            </ul>
        </div>
        <div class="tab-pane" id="rp-favorites">
            <h5 class="sidebartitle">Favorites</h5>
            <ul class="chatuserlist">
 
                <li>
                    <div class="media">
                        <a href="#" class="pull-left media-thumb">
                            <img alt="" src="../../images/photos/user1.png" class="media-object">
                        </a>
                        <div class="media-body">
                            <strong>Ashar Babar</strong>
                            <small>Tucson, AZ</small>
                        </div>
                    </div><!-- media -->
                </li>

            </ul>
        </div>
        <div class="tab-pane" id="rp-history">
            <h5 class="sidebartitle">History</h5>
            <ul class="chatuserlist">
                <li class="online">
                    <div class="media">
                        <a href="#" class="pull-left media-thumb">
                            <img alt="" src="../../images/photos/user4.png" class="media-object">
                        </a>
                        <div class="media-body">
                            <strong>Ashar Babar</strong>
                            <small>Did you sell the UPP Holding?</small>
                        </div>
                    </div><!-- media -->
                </li>

            </ul>
        </div>
        <div class="tab-pane pane-settings" id="rp-settings">
            
            <h5 class="sidebartitle mb20">Settings</h5>
            <div class="form-group">
                <label class="col-xs-8 control-label">Show Offline Users</label>
                <div class="col-xs-4 control-label">
                    <div class="toggle toggle-success"></div>
                </div>
            </div>
            
            <div class="form-group">
                <label class="col-xs-8 control-label">Enable History</label>
                <div class="col-xs-4 control-label">
                    <div class="toggle toggle-success"></div>
                </div>
            </div>
            
            <div class="form-group">
                <label class="col-xs-8 control-label">Show Full Name</label>
                <div class="col-xs-4 control-label">
                    <div class="toggle-chat1 toggle-success"></div>
                </div>
            </div>
            
            <div class="form-group">
                <label class="col-xs-8 control-label">Show Location</label>
                <div class="col-xs-4 control-label">
                    <div class="toggle toggle-success"></div>
                </div>
            </div>
            
        </div><!-- tab-pane -->
        
    </div><!-- tab-content -->
  </div><!-- rightpanel -->
  
  
</section>

<script src="../../js/jquery-1.10.2.min.js"></script>
<script src="../../js/jquery-migrate-1.2.1.min.js"></script>
<script src="../../js/bootstrap.min.js"></script>
<script src="../../js/modernizr.min.js"></script>
<script src="../../js/jquery.sparkline.min.js"></script>
<script src="../../js/toggles.min.js"></script>
<script src="../../js/retina.min.js"></script>
<script src="../../js/jquery.cookies.js"></script>

<script src="../../js/jquery-ui-1.10.3.min.js"></script>
<script src="../../js/chosen.jquery.min.js"></script>

<script src="../../js/custom.js"></script>
<script>
    jQuery(document).ready(function() {
        
        // Chosen Select
        jQuery(".chosen-select").chosen({'width':'100%','white-space':'nowrap'});
        
	  // Date Picker
	  jQuery('#datepicker').datepicker();
	  
	  jQuery('#datepicker-inline').datepicker();
	  
	  jQuery('#datepicker-multiple').datepicker({
		numberOfMonths: 3,
		showButtonPanel: true
  });
		
    });
</script>

</body>
</html>
