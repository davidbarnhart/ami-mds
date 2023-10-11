$ExportPath = 'C:\Users\BennettJ\Documents\Models\';

Remove-Item –path "$($ExportPath)*" -include *.pkg -Force;

Set-Location C:\"Program Files"\"Microsoft SQL Server"\130\"Master Data Services"\Configuration;

.\MDSModelDeploy.exe createpackage -model Customer -package "$($ExportPath)Customer.pkg" -version "VERSION_1" -includedata;