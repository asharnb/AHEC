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

  <!--Set up Page Variables for Header include-->
  <cfset This.PageName = 'Add Preceptors'>
  <cfset This.Icon = 'fa fa-plus'>
  <!--Set up Page Variables for Navigation include-->
  <cfset This.CurrentLevel = '2'>
  <cfset This.HostName = '#cgi.script_name#'>
  <cfset This.ActiveFolder = 'hp'>
  <cfset This.ActiveSubFolder = 'hpPreceptor'>
  <!--Database Calls-->
  <!--- new adding stuff --->
  <cfquery name="rCredentials" datasource="#datasource2#">
  SELECT * FROM Credentials ORDER BY ID ASC
</cfquery>

<!--- select from the specialties --->
<cfquery name="rSpecialties" datasource="#datasource2#">
SELECT * FROM Specialties ORDER BY ID ASC
</cfquery>
<!--- select from the Languages --->    
<cfquery name="rLanguages" datasource="#datasource2#">
SELECT * FROM Languages ORDER BY ID ASC
</cfquery>
<!--- select from the Site --->
<cfquery name="rSites" datasource="#datasource2#">
SELECT * FROM Sites ORDER BY ID ASC
</cfquery>
<!--- select from the Organizations --->
<cfquery name="rOrganizations" datasource="#datasource2#">
SELECT * FROM Organizations ORDER BY ID ASC
</cfquery>

<!--- read State --->

<cfquery name="rStates" datasource="#datasource2#">
SELECT * FROM States ORDER BY ID ASC
</cfquery>  


<!--Add Record on validation-->


<cfif IsDefined("FORM.addPreceptorHDN") AND FORM.addPreceptorHDN EQ "True">

  <cfquery datasource="#datasource2#">
  INSERT INTO dbo.Preceptors(Status
   ,PLastName
   ,PFirstName
   ,PMiddleName
   ,BoardStatus
   ,Malpractice
   ,PreceptorEmail
   ,PreceptorPhone
   ,FirstYearPractice
   ,FirstYearPreceptor
   )
  VALUES (
  <cfif IsDefined("FORM.status")>
  1
  <cfelse>
  0
  </cfif>
    ,
    <cfif IsDefined("FORM.FirstName") AND #FORM.FirstName# NEQ "">
    <cfqueryparam value="#FORM.FirstName#" cfsqltype="cf_sql_clob" maxlength="50">
    <cfelse>
    ''
    </cfif>
    ,
    <cfif IsDefined("FORM.LastName") AND #FORM.LastName# NEQ "">
    <cfqueryparam value="#FORM.LastName#" cfsqltype="cf_sql_clob" maxlength="50">
    <cfelse>
    ''
    </cfif>
    ,
    <cfif IsDefined("FORM.MiddleName") AND #FORM.MiddleName# NEQ "">
    <cfqueryparam value="#FORM.MiddleName#" cfsqltype="cf_sql_clob" maxlength="50">
    <cfelse>
    ''
    </cfif>
    ,
    <cfif IsDefined("FORM.BoardStatus") AND #FORM.BoardStatus# NEQ "">
    <cfqueryparam value="#FORM.BoardStatus#" cfsqltype="cf_sql_clob" maxlength="50">
    <cfelse>
    ''
    </cfif>
    ,
    <cfif IsDefined("FORM.malpractice") AND #FORM.malpractice# NEQ "">
    <cfqueryparam value="#FORM.malpractice#" cfsqltype="cf_sql_clob" maxlength="50">
    <cfelse>
    ''
    </cfif>
    ,
    <cfif IsDefined("FORM.PreceptorEmail") AND #FORM.PreceptorEmail# NEQ "">
    <cfqueryparam value="#FORM.PreceptorEmail#" cfsqltype="cf_sql_clob" maxlength="50">
    <cfelse>
    ''
    </cfif>
    ,
    <cfif IsDefined("FORM.PreceptorPhone") AND #FORM.PreceptorPhone# NEQ "">
    <cfqueryparam value="#FORM.PreceptorPhone#" cfsqltype="cf_sql_clob" maxlength="50">
    <cfelse>
    ''
    </cfif>
    ,
    <cfif IsDefined("FORM.FirstYearPractice") AND #FORM.FirstYearPractice# NEQ "">
    <cfqueryparam value="#FORM.FirstYearPractice#" cfsqltype="cf_sql_clob" maxlength="50">
    <cfelse>
    ''
    </cfif>

    ,
    <cfif IsDefined("FORM.FirstYearPreceptor") AND #FORM.FirstYearPractice# NEQ "">
    <cfqueryparam value="#FORM.FirstYearPreceptor#" cfsqltype="cf_sql_clob" maxlength="50">
    <cfelse>
    ''
    </cfif>




  )

</cfquery>

<!--- <cfset This.ID = '#GetPreceptorsID.PreceptorsID#'> --->

<!--Get GetPreceptorsID -->

<cfquery name="GetPreceptorsID" datasource="#datasource2#">
SELECT max(ID) as PreceptorsID FROM dbo.Preceptors
</cfquery> 
<cfset This.ID = '#GetPreceptorsID.PreceptorsID#'>
<!--Add Credentials-->
<cfloop index="Credentials" list="#FORM.PreceptorsCredentials#" delimiters=",">
  <cfquery datasource="#datasource2#">   
  INSERT INTO dbo.PreceptorsCredentials (PreceptorID,CredentialID)
  VALUES (#This.ID#, #Credentials#)
</cfquery> 
</cfloop> 

<!--- Add Specialties   6/20/14 --->
 <cfloop index="Specialties" list="#FORM.PreceptorsSpecialties#" delimiters=",">
  <cfquery datasource="#datasource2#">   
  INSERT INTO dbo.PreceptorsSpecialties (PreceptorID,SpecialtyID)
  VALUES (#This.ID#, #Specialties#)
</cfquery> 
</cfloop> 


<!--- Add Languages   7/11/14 --->
<cfloop index="Languages" list="#FORM.PreceptorsLanguages#" delimiters=",">
  <cfquery datasource="#datasource2#">   
  INSERT INTO dbo.PreceptorsLanguaes (PreceptorID,LanguageID)
  VALUES (#This.ID#, #Languages#)
</cfquery> 
</cfloop> 

<!--- Add Sites  7/11/14 --->
<cfloop index="SitesName" list="#FORM.PreceptorsSites#" delimiters=",">
  <cfquery datasource="#datasource2#">   
  INSERT INTO dbo.PreceptorsSites (PreceptorID,SitesID)
  VALUES (#This.ID#, #SitesName#)
</cfquery> 
</cfloop>      



<cfloop index="Organization" list="#FORM.PreceptorsAffiliation#" delimiters=",">
  <cfquery datasource="#datasource2#">   
  INSERT INTO dbo.PreceptorsAffiliation (PreceptorID,OrganizationID)
  VALUES (#This.ID#, #Organization#)
</cfquery> 
</cfloop>  




<cfset Session.NewPreceptorAdded="Yes">
<cfset Session.PreceptorMode="V">
<cflocation url = "aPreceptor.cfm" addtoken="no">

</cfif>

<!DOCTYPE html>
  <html lang="en">
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
      <meta name="description" content="">
      <meta name="author" content="Ashar Babar Concepts">
      <link rel="shortcut icon" href="../../images/favicon.ico" type="image/png">
      <title>AZAHEC Admin - Add Trainee</title>
      <link href="../../css/style.default.css" rel="stylesheet">
      <link href="../../css/jquery.datatables.css" rel="stylesheet">
      <link href="../../css/jquery.gritter.css" rel="stylesheet">

      <link rel="stylesheet" type="text/css" href="http://redbar.arizona.edu/sites/default/files/ua-banner/ua-web-branding/css/ua-web-branding.css">
      <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->

  </head>

  <body>


    <!--UA Web Banner -->
    <div id="ua-web-branding-banner-v1" class="ua-wrapper bgLight dark-gray-grad twenty-five">
      <a class="ua-home asdf" href="http://arizona.edu" title="The University of Arizona">
        <p>The University of Arizona</p>
      </a>
    </div>
    <section> 

      <!-- leftpanel -->
      <cfinclude template="../../includes/leftpanel.cfm">
      <!-- leftpanel --> 

      <!-- mainpanel start -->
      <div class="mainpanel"> 

        <!-- header -->
        <cfinclude template="../../includes/header.cfm" >
        <!-- header --> 

        <!-- content dynamic -->
        <div class="contentpanel">
          <form class="form-horizontal form-bordered" id="addPreceptor" method="Post">


            <div class="panel panel-default">


              <div class="panel-heading">
                <h4 class="panel-title">Add New Precepter</h4>
                <p>Please use this form to add new precepter. Make sure to fill out all the required fields.</p>
                <p class="error"></p>
              </div>

              <div class="panel-body panel-body-nopadding">

                <div class="form-group">
                  <div class="reqd">
                    <label class="col-sm-2 control-label">Status <span class="asterisk">*</span></label>
                    <div class="col-sm-4">
                      <div class="rdio rdio-primary">
                        <input type="radio" name="status" value="1" id="statusActive" checked="checked">
                        <label for="statusActive">Active</label>
                      </div>
                      <div class="rdio rdio-primary">
                        <input type="radio" name="status" value="0" id="statusInActive" disabled>
                        <label for="statusInActive">Inactive</label>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-2 control-label">Last Name <span class="asterisk">*</span></label>
                  <div class="col-sm-4">
                    <input type="text" placeholder="Enter Last Name" class="form-control" name="LastName" required>
                  </div>
                  <label class="col-sm-2 control-label">First Name <span class="asterisk">*</span></label>
                  <div class="col-sm-4">
                    <input type="text" placeholder="Enter First Name" class="form-control" name="FirstName" required>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-2 control-label">Middle Name</label>
                  <div class="col-sm-4">
                    <input type="text" placeholder="Enter Middle Name" class="form-control" name="MiddleName">
                  </div>
                </div>
              </div>
              <!-- panel-body --> 

            </div>


            <!--- Credentials --->
            <div class="panel panel-default">
              <div class="panel-heading">
                <h4 class="panel-title">Field of work</h4>
              </div>
              <div class="panel-body panel-body-nopadding">
                <div class="form-group">
                  <div class="reqd" >      
                    <label class="col-sm-2 control-label">Credentials<span class="asterisk">*</span></label>
                    <div class="col-sm-10">
                      <select class="form-control chosen-select" multiple data-placeholder="Choose Preceptors's Credentials.." name="PreceptorsCredentials" required>
                        <option value=""></option>
                        <cfoutput query="rCredentials">
                          <option value="#ID#">#Credentials#</option>
                        </cfoutput>
                      </select>
                      <label class="error" for="SitePartners"></label>
                    </div>
                  </div>
                </div>

                <!--- Specialties --->

                <div class="form-group">
                  <div class="reqd" >      
                    <label class="col-sm-2 control-label">Specialty<span class="asterisk">*</span></label>
                    <div class="col-sm-10">
                      <select class="form-control chosen-select" multiple data-placeholder="Choose Preceptors's Specialty.." name="PreceptorsSpecialties" required>
                        <option value=""></option>
                       <cfoutput query="rSpecialties">
                        <option value="#ID#">#Specialty#</option>
                      </cfoutput>
                    </select>
                    <label class="error" for="SitePartners"></label>
                  </div>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label">Malpractice<span class="asterisk">*</span></label>
                <div class="col-sm-4">
                  <div class="rdio rdio-primary">
                    <input type="radio" name="malpractice" value="active" id="active" >
                    <label for="active">active</label>
                  </div>
                  <div class="rdio rdio-primary">
                    <input type="radio" name="malpractice" value="inactive" id="inactive">
                    <label for="inactive">Inactive</label>
                  </div>
                  <label class="error" for="inactive"></label>
                </div>
              </div>

              <!---  --->
              <div class="form-group">
                <label class="col-sm-2 control-label">BoardStatus</label>
                <div class="col-sm-4">
                  <select class="form-control" data-placeholder="Choose a Level..." name="BoardStatus">
                    <option value="">Choose a BoardStatus...</option>
                    <option value="0">Board certified</option>
                    <option value="1">Board eligible</option>
                    <option value="2">Not board certified</option>

                  </select>
                </div>
              </div>





              <div class="form-group">
                <label class="col-sm-2 control-label">States License</label>

                <div class="col-sm-3">
                  <select class="form-control" name="">
                    <option value=""></option>
                    <cfoutput query="rStates">
                      <option value="#States#">#States# (#States_abb#)</option>
                    </cfoutput>
                  </select>
                </div>
                <label class="col-sm-2 control-label">License Expiration</label>
                <div class="col-sm-2">
                  <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                  <input type="text" placeholder="Month" id="Month" class="form-control" name="AnticDate">
                </div>
              </div>
              <!---  <label class="col-sm-1 control-label">License Expiration</label> --->
              <div class="col-sm-3">
                <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                <input type="text" placeholder="Year" id="Year" class="form-control" name="AnticDate">
              </div>
            </div>  
          </div>

          <!--- for the  --->
          <div class="form-group">
            <label class="col-sm-2 control-label">BoardStatus</label>
            <div class="col-sm-4">
              <select class="form-control" data-placeholder="Choose a Level..." name="InstitutionLevel">
                <option value="">Choose a BoardStatus...</option>
                <option value="0">Board certified</option>
                <option value="1">Board eligible</option>
                <option value="2">Not board certified</option>

              </select>
            </div>
          </div>

          <div class="form-group">    
            <label class="col-sm-2 control-label">Languages</label>
            <div class="col-sm-10">
              <select class="form-control chosen-select" multiple data-placeholder="Choose Preceptors's Languages.." name="PreceptorsLanguages" required>
                <option value=""></option>
               <cfoutput query="rLanguages">
                <option value="#ID#">#Languages#</option>
              </cfoutput>
            </select>
            <!---   <label class="error" for="SitePartners"></label> --->
          </div>

        </div>

      </div>
      <!-- panel-body --> 
    </div>




    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">Place of work</h4>
      </div>
      <div class="panel-body panel-body-nopadding">
       <div class="form-group">   
        <label class="col-sm-2 control-label">Site<span class="asterisk">*</span></label>
        <div class="col-sm-10">
          <select class="form-control chosen-select" multiple data-placeholder="Choose Preceptors's Sites.." name="PreceptorsSites" required>

            <cfoutput query="rSites">
              <option value="#ID#">#SiteName#</option>
            </cfoutput>
          </select>
          <!---   <label class="error" for="SitePartners"></label> --->
        </div>
      </div>
    </div>
    <div class="form-group">
      <label class="col-sm-2 control-label">Preceptor Email</label>
      <div class="col-sm-4">
        <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
        <input type="text" placeholder="Preceptor Email" name="PreceptorEmail" class="form-control">
      </div>
    </div>
    <label class="col-sm-2 control-label">Preceptor Phone</label>
    <div class="col-sm-4">
      <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
      <input type="text" placeholder="Preceptor Phone" id="phone" name="PreceptorPhone" class="form-control">
    </div>
  </div>
</div>
</div>

<div class="panel panel-default">
  <div class="panel-heading">
    <h4 class="panel-title">History</h4>
  </div>
  <div class="form-group">

    <label class="col-sm-2 control-label">AffiliationAgreement</label>
    <div class="col-sm-10">
      <select class="form-control chosen-select" multiple data-placeholder="Choose Preceptors's Specialty.." name="PreceptorsAffiliation" >
       <!---  <option value=""></option> --->
       <cfoutput query="rOrganizations">
        <option value="#ID#">#Organization#</option>
      </cfoutput>
    </select>
    <label class="error" for="SitePartners"></label>
  </div>

</div>

<div class="form-group">
 <label class="col-sm-2 control-label">FirstYearPractice</label>

 <div class="col-sm-4">
  <select class="form-control" data-placeholder="Choose a Year..." name="FirstYearPractice">
    <option value="">Choose a Year...</option>
    <option value="0">2014</option>
    <option value="1">2013</option>
    <option value="2">2012</option>
  </select>
</div>
<label class="col-sm-2 control-label">FirstYearPreceptor</label>
<div class="col-sm-4">
  <select class="form-control" data-placeholder="Choose a Year..." name="FirstYearPreceptor">
    <option value="">Choose a Year...</option>
    <option value="0">2014</option>
    <option value="1">2013</option>
    <option value="2">2012</option>
  </select>
</div>
</div>
</div>

<div class="panel-footer">
  <div class="row">
    <div class="col-sm-12 ">
      <input type="hidden" name="addPreceptorHDN" value="True">
      <button class="btn btn-primary">Submit</button>
      &nbsp;
      <button class="btn btn-default">Cancel</button>
    </div>
  </div>
</div>



<!-- panel-body --> 
</div>


</div>
</div>
</form>
<!-- contentpanel --> 

</div>
<!-- mainpanel end -->


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

<script src="../../js/jquery.validate.min.js"></script>
<script src="../../js/jquery.maskedinput.min.js"></script>
<script src="../../js/jquery.gritter.min.js"></script>

<script src="../../js/custom.js"></script> 

<script>
// Form validation
jQuery(document).ready(function(){ 

  $.validator.setDefaults({ ignore: ":hidden:not(select)"})
  jQuery("#addPreceptor").validate({
    rules: {
     "FirstName": {
       required: true,
       minlength: 2,
     },
     "LastName": {
       required: true,
       minlength: 2,
     },
     "EmailPreferred": {
       required: true,
       email: true,
     }   

   },

   messages: {
    "FirstName": {
     required: "This Field is required",
     minlength: "This field must contain at least {0} characters",
   },
   "LastName": {
     required: "This Field is required",
     minlength: "This field must contain at least {0} characters",
   },
   "EmailPreferred": {
     required: "This Field is required",
     email: "This field must contain a valid email",
   }       
 },

});

});

</script>

<script>
jQuery(document).ready(function() {

        // Chosen Select
        jQuery(".chosen-select").chosen({'width':'100%','white-space':'nowrap'});
        // Masked Inputs
        jQuery("#LicenseExp").mask("99/9999");
        jQuery("#Month").mask("99");
        jQuery("#Year").mask("9999");
        jQuery("#AnticDate").mask("99/9999");
        jQuery("#phone").mask("(999) 999-9999");
        jQuery("#EmergContactPhone").mask("(999) 999-9999");

      });

</script>
</body>
</html>
