$Nodes = New-CimSession -ComputerName APP1,APP2
 
Foreach ($Node in $Nodes){
        
        $Status = Get-DscconfigurationStatus -CimSession $Node
 
        $tableAdd = New-Object Psobject -Property @{
        DesiredState = (Test-DscConfiguration -CimSession $Node -Detailed).InDesiredState
        NIDS = (Test-DscConfiguration -CimSession $Node -Detailed).ResourcesNotInDesiredState
        Node = $node.ComputerName
        Configuration = (Get-DscConfiguration -CimSession $Node).ResourceID
        ConfigurationMode = (Get-DscLocalConfigurationManager -CimSession $Node).ConfigurationMode
        Status = $Status.Status
        Lastcheck = $Status.StartDate
        Type = $Status.Type
        RefreshMode = $Status.Mode

        
    }

[Array]$Output +=
@"
</tr>
<tr>
<td>$($TableAdd.Node)</td>
<td>$($TableAdd.DesiredState)</td>
<td>$($TableAdd.RefreshMode)</td>
<td>$($TableAdd.ConfigurationMode)</td>
<td>$($TableAdd.Configuration)</td>
<td>$($TableAdd.LastCheck)</td>
<td>$($TableAdd.Status)</td>
<td>$($TableAdd.NIDS)</td>
</tr>
"@
 
}

$Table = @"
<table border="1">
<tr>
<th>Node</th>
<th>DesiredState</th>
<th>RefreshMode</th>
<th>ConfigurationMode</th>
<th>Configuration</th>
<th>LastCheck</th>
<th>Status</th>
<th>NIDS</th>
$Output</table>
"@

$html = @"
<!DOCTYPE HTML>
<!--
	Hyperspace by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>Hyperspace by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
	</head>
	<body>

		<!-- Sidebar -->
			<section id="sidebar">
				<div class="inner">
					<nav>
						<ul>
							<li><a href="#intro">DSC</a></li>
							<li><a href="#one">DSC Status</a></li>
							<li><a href="#two">JEA Status</a></li>
							<li></li>
						</ul>
					</nav>
				</div>
			</section>

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Intro -->
					<section id="intro" class="wrapper style1 fullscreen fade-up">
						<div class="inner">
							<h1>DSC And JEA Console</h1>
							<p>Desired State and JEA status<br />
							</p>
							<ul class="actions">
								<li><a href="#one" class="button scrolly">Learn more</a></li>
							</ul>
						</div>
					</section>

				<!-- One -->
					<section id="one" class="wrapper style2 spotlights">
						<section>
							
							<div class="content">
								<div class="inner">
									<h2>Configuration Status</h2>
                                    $table
									
									<ul class="actions">
										<li></li>
									</ul>
								</div>
							</div>
						</section>
						<section>
						

				<!-- Two -->
					<section id="two" class="wrapper style2 spotlights">
						<section>
							
							<div class="content">
								<div class="inner">
									<h2>JEA Status</h2>
                                    
									
									<ul class="actions">
										<li></li>
									</ul>
								</div>
							</div>
						</section>
						<section>

				<!-- Three -->
					
			

		<!-- Footer -->
			<footer id="footer" class="wrapper style1-alt">
				<div class="inner">
					<ul class="menu">
						<li>&copy; Untitled. All rights reserved.</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
					</ul>
				</div>
			</footer>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrollex.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="assets/js/main.js"></script>

	</body>
</html>

"@

$html | out-file C:\inetpub\wwwroot\HTML\index.html -Encoding utf8
