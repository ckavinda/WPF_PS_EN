[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') 				| out-null
[System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.dll')       				| out-null

function LoadXml ($global:filename)
{
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}

# Load MainWindow
$XamlMainWindow=LoadXml("Datagrid_GUI.xaml")
$Reader=(New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form=[Windows.Markup.XamlReader]::Load($Reader)

$Global:Current_Folder =(get-location).path 


########################################################################################################################################################################################################	
#*******************************************************************************************************************************************************************************************************
# 																		BUTTONS AND LABELS INITIALIZATION 
#*******************************************************************************************************************************************************************************************************
########################################################################################################################################################################################################

# ListBox
$DataGrid_XML = $Form.findname("DataGrid_XML")

$Global:XML_Row_List = $DataGrid_XML.items

Function Populate_Datagrid_XML # Function to list your applications in the datagrid
	{			
		$Global:List_XML_Content = ""
		$Input_XML = ""		
		
		$Global:List_XML_Content = "DeploymentShare_Infos.xml"						
		$Input_XML = [xml] (Get-Content $List_XML_Content)		
		foreach ($data in $Input_XML.selectNodes("DeploymentShares/DeploymentShare"))		
			{
				$XML_values = New-Object PSObject
				$XML_values = $XML_values | Add-Member NoteProperty Label $data.Label –passthru				
				$XML_values = $XML_values | Add-Member NoteProperty Path $data.Path –passthru
				$XML_values = $XML_values | Add-Member NoteProperty Version $data.Version –passthru
				$DataGrid_XML.Items.Add($XML_values) > $null
			}		
	}		
	


Populate_Datagrid_XML
########################################################################################################################################################################################################	
#*******************************************************************************************************************************************************************************************************
# 																		BUTTONS ACTIONS 
#*******************************************************************************************************************************************************************************************************
########################################################################################################################################################################################################
	

	
	
	

$Form.ShowDialog() | Out-Null

