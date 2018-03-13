
#Run this in admin mode

Set-Location C:\"Program Files"\"Microsoft SQL Server"\130\"Master Data Services"\Configuration;

#.\MDSModelDeploy.exe listservices

.\MDSModelDeploy.exe deploynew -package e:\Customer.pkg -model Customer -service MDS1

#.\MDSModelDeploy.exe deployupdate -package e:\Customer.pkg -version VERSION_1