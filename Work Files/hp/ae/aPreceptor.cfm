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
    <cfset This.ActiveSubFolder = 'hpTrainees'>
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


<cfquery name="rInstitutions" datasource="#datasource2#">
  SELECT * FROM Institutions ORDER BY Institution ASC
</cfquery>

<cfquery name="rDisciplines" datasource="#datasource2#">
  SELECT * FROM Disciplines ORDER BY Discipline ASC
</cfquery>

<cfquery name="rDegrees" datasource="#datasource2#">
  SELECT * FROM DegreeList ORDER BY DegreeTitle ASC
</cfquery>  

<!--- read State --->

<cfquery name="rStates" datasource="#datasource2#">
  SELECT * FROM States ORDER BY ID ASC
</cfquery>  


<!--Add Record on validation-->
<cfif IsDefined("FORM.addTraineeHDN") AND FORM.addTraineeHDN EQ "True">
  <cfquery datasource="#datasource2#">   
    INSERT INTO dbo.Trainees (Status, LastName, FirstName, MiddleName, MaidenName, EmailPreferred, EmailUniversity, EmailPermanent, Phone, EmergContactName, EmergContactPhone, InstitutionID, InstitutionLevel, DisciplineID, Enrollment, DOB, Sex, Ethnicity, Race, RuralBackground, Disadvantaged, AZbackground, MilitaryStatusPre, SpecialHousing, Notes, CreatedBy, LastEditedBy, DateUpdated)
VALUES (<cfif IsDefined("FORM.Status") AND #FORM.Status# NEQ "">
<cfqueryparam value="#FORM.Status#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.LastName") AND #FORM.LastName# NEQ "">
<cfqueryparam value="#FORM.LastName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.FirstName") AND #FORM.FirstName# NEQ "">
<cfqueryparam value="#FORM.FirstName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.MiddleName") AND #FORM.MiddleName# NEQ "">
<cfqueryparam value="#FORM.MiddleName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.MaidenName") AND #FORM.MaidenName# NEQ "">
<cfqueryparam value="#FORM.MaidenName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.EmailPreferred") AND #FORM.EmailPreferred# NEQ "">
<cfqueryparam value="#FORM.EmailPreferred#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.EmailUniversity") AND #FORM.EmailUniversity# NEQ "">
<cfqueryparam value="#FORM.EmailUniversity#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.EmailPermanent") AND #FORM.EmailPermanent# NEQ "">
<cfqueryparam value="#FORM.EmailPermanent#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Phone") AND #FORM.Phone# NEQ "">
<cfqueryparam value="#FORM.Phone#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.EmergContactName") AND #FORM.EmergContactName# NEQ "">
<cfqueryparam value="#FORM.EmergContactName#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.EmergContactPhone") AND #FORM.EmergContactPhone# NEQ "">
<cfqueryparam value="#FORM.EmergContactPhone#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.InstitutionID") AND #FORM.InstitutionID# NEQ "">
<cfqueryparam value="#FORM.InstitutionID#" cfsqltype="cf_sql_numeric">
<cfelse>
NULL
</cfif>
, <cfif IsDefined("FORM.InstitutionLevel") AND #FORM.InstitutionLevel# NEQ "">
<cfqueryparam value="#FORM.InstitutionLevel#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Discipline") AND #FORM.Discipline# NEQ "">
<cfqueryparam value="#FORM.Discipline#" cfsqltype="cf_sql_numeric">
<cfelse>
NULL
</cfif>
, <cfif IsDefined("FORM.Enrollment") AND #FORM.Enrollment# NEQ "">
<cfqueryparam value="#FORM.Enrollment#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.DOB") AND #FORM.DOB# NEQ "">
<cfqueryparam value="#FORM.DOB#" cfsqltype="cf_sql_timestamp">
<cfelse>
NULL
</cfif>
, <cfif IsDefined("FORM.Sex") AND #FORM.Sex# NEQ "">
<cfqueryparam value="#FORM.Sex#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Ethnicity") AND #FORM.Ethnicity# NEQ "">
<cfqueryparam value="#FORM.Ethnicity#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Race") AND #FORM.Race# NEQ "">
<cfqueryparam value="#FORM.Race#" cfsqltype="cf_sql_clob" maxlength="150">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.RuralBackground") AND #FORM.RuralBackground# NEQ "">
<cfqueryparam value="#FORM.RuralBackground#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Disadvantaged") AND #FORM.Disadvantaged# NEQ "">
<cfqueryparam value="#FORM.Disadvantaged#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.AZbackground") AND #FORM.AZbackground# NEQ "">
<cfqueryparam value="#FORM.AZbackground#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.MilitaryStatusPre") AND #FORM.MilitaryStatusPre# NEQ "">
<cfqueryparam value="#FORM.MilitaryStatusPre#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.SpecialHousing") AND #FORM.SpecialHousing# NEQ "">
<cfqueryparam value="#FORM.SpecialHousing#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
, <cfif IsDefined("FORM.Notes") AND #FORM.Notes# NEQ "">
<cfqueryparam value="#FORM.Notes#" cfsqltype="cf_sql_clob" maxlength="4000">
<cfelse>
''
</cfif>
,
<cfqueryparam value="#Session.UserID#" cfsqltype="cf_sql_clob" maxlength="50">
,
<cfqueryparam value="#Session.UserID#" cfsqltype="cf_sql_clob" maxlength="50">
,DEFAULT
)
  </cfquery>
 <!--Get GetPreceptorsID -->

    <cfquery name="GetPreceptorsID" datasource="#datasource2#">
      SELECT max(ID) as PreceptorsID FROM dbo.Preceptors
  </cfquery> 

<cfset This.ID = '#GetPreceptorsID.PreceptorsID#'>
 <!--Add Credentials-->
    <cfloop index="Credentials" list="#FORM.PreceptorsCredentials#" delimiters=",">
        <cfquery datasource="#datasource2#">   
            INSERT INTO dbo.PreceptorsCredentials (PreceptorsID,CredentialsID)
        VALUES (#This.ID#, #Credentials#)
        </cfquery> 
     </cfloop> 

     <!--- Add Specialties   6/20/14 --->
        <cfloop index="Specialties" list="#FORM.PreceptorsSpecialties#" delimiters=",">
        <cfquery datasource="#datasource2#">   
            INSERT INTO dbo.PreceptorsSpecialties (PreceptorsID,SpecialtiesID)
        VALUES (#This.ID#, #Specialty#)
        </cfquery> 
     </cfloop> 


      <!--- Add Languages   7/11/14 --->
     <cfloop index="Languages" list="#FORM.PreceptorsLanguages#" delimiters=",">
        <cfquery datasource="#datasource2#">   
            INSERT INTO dbo.PreceptorsSpecialties (PreceptorsID,LanguagesID)
        VALUES (#This.ID#, #Languages#)
        </cfquery> 
     </cfloop> 

     PreceptorsSites
      <!--- Add Languages   7/11/14 --->
     <cfloop index="SitesName" list="#FORM.PreceptorsSites#" delimiters=",">
        <cfquery datasource="#datasource2#">   
            INSERT INTO dbo.PreceptorsSites (PreceptorsID,SitesID)
        VALUES (#This.ID#, #SitesName#)
        </cfquery> 
     </cfloop>      


  
  <cfquery name="GetTraineeID" datasource="#datasource2#">
      SELECT max(ID) as TraineeID FROM dbo.Trainees
  </cfquery>
  <cfset This.ID = '#GetTraineeID.TraineeID#'>


    
<cfquery datasource="#datasource2#">   
    INSERT INTO dbo.Degrees (TraineeID,AnticDegree,AnticDate)
VALUES (#This.ID#
, <cfif IsDefined("FORM.AnticDegree") AND #FORM.AnticDegree# NEQ "">
<cfqueryparam value="#FORM.AnticDegree#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
,<cfif IsDefined("FORM.antdate") AND #FORM.antdate# NEQ "">
<cfqueryparam value="#FORM.AnticDate#" cfsqltype="cf_sql_clob" maxlength="50">
<cfelse>
''
</cfif>
)
</cfquery>
  <cfset Session.NewTraineeAdded="Yes">
  <cfset Session.TraineeMode="V">
  <cflocation url = "vTrainee.cfm?id=#this.ID#" addtoken="no">
      
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
          <h4 class="panel-title">Preceptor's field of work</h4>
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
               <!---  <option value=""></option> --->
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
                <input type="radio" name="sex" value="1" id="sexMale" >
                <label for="sexMale">active</label>
              </div>
              <div class="rdio rdio-primary">
                <input type="radio" name="sex" value="0" id="sexFemale">
                <label for="sexFemale">Inactive</label>
              </div>
              <label class="error" for="sex"></label>
            </div>
          </div>
          
<!---  --->
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
               <!---  <option value=""></option> --->
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




          <div class="form-group">
            <label class="col-sm-2 control-label">Preceptor Email</label>
            <div class="col-sm-4">
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                <input type="text" placeholder="Preceptor Email" name="EmailPermanent" class="form-control">
              </div>
            </div>
            <label class="col-sm-2 control-label">Preceptor Phone</label>
            <div class="col-sm-4">
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                <input type="text" placeholder="Preceptor Phone" id="phone" name="phone" class="form-control">
              </div>
            </div>
          </div>
        </div>
        <!-- panel-body --> 
      </div>

      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">History</h4>
        </div>
        <div class="panel-body panel-body-nopadding">
          <div class="form-group">
            <label class="col-sm-2 control-label">Date of Birth</label>
            <div class="col-sm-4">
              <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                <input type="text" placeholder="DOB" name="DOB" class="form-control">
              </div>
            </div>
            <label class="col-sm-2 control-label">Sex <span class="asterisk">*</span></label>

          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="Ethnicity">Ethnicity</label>
            <div class="col-sm-4">
              <select class="form-control" name="Ethnicity">
                <option value="">Choose an Ethnicity...</option>
                <option value="Hispanic/Latino">Hispanic/Latino</option>
                <option value="Non-Hispanic/Non-Latino">Non-Hispanic/Non-Latino</option>
                <option value="Not reported">Not reported</option>
              </select>
            </div>
            <label class="col-sm-2 control-label">Race</label>
            <div class="col-sm-4">
              <select class="form-control" name="Race">
                <option value="">Choose an Race...</option>
                <option value="American Indian or Alsaka Native">American Indian or Alsaka Native</option>
                <option value="Asian(Chinese,Filipino,Japanese,Korean,Asian Indian or Thai)">Asian(Chinese,Filipino,Japanese,Korean,Asian Indian or Thai)</option>
                <option value="Other Asian">Other Asian</option>
                <option value="Black or African American">Black or African American</option>
                <option value="Native Hawaiian/Other Pacific Islander">Native Hawaiian/Other Pacific Islander</option>
                <option value="White">White</option>
                <option value="Other(Not Reported)">Other(Not Reported)</option>
                <option value="More than one race">More than one race</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Rural Background</label>
            <div class="col-sm-4">
              <select class="form-control" name="RuralBackground">
                <option value="">Choose an Option...</option>
                <option value="Yes">Yes</option>
                <option value="No">No</option>
                <option value="Not Reported">Not Reported</option>
              </select>
              <span class="help-block">Did the trainee grow up in a rural area (&lt;50,000 people)?</span> </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Disadvantaged</label>
            <div class="col-sm-8">
              <select class="form-control" name="Disadvantaged">
                <option value="">Choose an Option...</option>
                <option value="Yes">Yes</option>
                <option value="No">No</option>
                <option value="Not Reported">Not Reported</option>
              </select>
              <span class="help-block"><strong>A trainee may be considered from a disadvantaged background if he/she can answer yes to one or more of the following statements:</strong>
              <p> 1. Student is the first generation in his/her family to attend college.</p>
              <p> 2. Student has or is currently receiving a scholarship or loan for disadvantaged students.</p>
              <p> 3. While growing up, student or family ever used federal or state assistance programs (such as free or reduced school lunch, subsidized housing, food stamps, Medicaid, etc.)</p>
              <p> 4. While growing up, student lived where there were few medical providers at a convenient distance.</p>
              </span> </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">AZ Background</label>
            <div class="col-sm-4">
              <select class="form-control" name="AZbackground">
                <option value="">Choose an Option...</option>
                <option value="Yes">Yes</option>
                <option value="No">No</option>
                <option value="Not Reported">Not Reported</option>
              </select>
              <span class="help-block">Did the trainee grow up in Arizona?</span> </div>
            <label class="col-sm-2 control-label">Military Status</label>
            <div class="col-sm-4">
              <select class="form-control" name="MilitaryStatusPre">
                <option value="">Choose an Option...</option>
                <option value="Individual is not a Veteran">Individual is not a Veteran</option>
                <option value="Active duty military">Active duty military</option>
                <option value="Reservist">Reservist</option>
                <option value="Veteran - Prior Service">Veteran - Prior Service</option>
                <option value="Veteran - Retired">Veteran - Retired</option>
                <option value="Not reported">Not reported</option>
              </select>
              <span class="help-block">Military status (pre-matriculation)</span> </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label">Special Housing</label>
            <div class="col-sm-4">
              <select class="form-control" name="SpecialHousing" >
                <option value="">Choose an Option...</option>
                <option value="Family">Family</option>
                <option value="Disability accommodation">Disability accommodation</option>
                <option value="Gender-specific">Gender-specific</option>
                <option value="Pets allowed">Pets allowed</option>
                <option value="Religious preference">Religious preference</option>
                <option value="Single-occupant">Single-occupant</option>
              </select>
              <span class="help-block">Special housing needs</span> </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" >Notes</label>
            <div class="col-sm-10">
              <textarea class="form-control" rows="3" name="Notes" ></textarea>
            </div>
          </div>
        </div>
        <!-- panel-body -->
        <div class="panel-footer">
          <div class="row">
            <div class="col-sm-12 ">
              <input type="hidden" name="addTraineeHDN" value="True">
              <button class="btn btn-primary">Submit</button>
              &nbsp;
              <button class="btn btn-default">Cancel</button>
            </div>
          </div>
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
