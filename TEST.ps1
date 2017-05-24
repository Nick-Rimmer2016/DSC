Configuration superwebservice
{
    param ($MachineName)
        Node $MachineName
        {
                #Install IIS Role
                WindowsFeature IIS
                {
                    Ensure = "Present"
                    Name = "Web-Server"
                }
                #Install ASP.NET 4.5
                WindowsFeature ASP
                {
                    Ensure = "Present"
                    Name = "web-Asp-Net45"
                }
        }
}

superwebservice -MachineName localhost
