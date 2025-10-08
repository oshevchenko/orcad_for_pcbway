# orcad_for_pcbway
Bash script to rename OrCAD Gerber files according to https://pcbway.com requirements.

PCBWAY requres the following extensions for Gerber files: https://www.pcbway.com/helpcenter/generate_gerber/Gerber_File_Extension_from_Different_Software.html

The content of the file **VCO_Gerber.zip** created by OrCAD:
```
TOP.art <- copper top
SSTP.art <- silkscreen top 
SSBT.art <- silkscreen bottom
BOTTOM.art <- copper bottom
OUTLINE.art <- outline
vco_collpits-1-2.drl <- drill file
etc...
```
The script renames them to:
```
TOP.art >>> VCO_Gerber.GTL                                                          
BOTTOM.art >>> VCO_Gerber.GBL                                                          
SMTP.art >>> VCO_Gerber.GTS                                                          
SMBT.art >>> VCO_Gerber.GBS                                                          
SSTP.art >>> VCO_Gerber.GTO                                                          
SSBT.art >>> VCO_Gerber.GBO
OUTLINE.art >>> VCO_Gerber.GKO
etc...
```
The name **VCO_Gerber** is taken from original **.zip** file.

# Usage
```
$ ./orcad_for_pcbway.sh ./vco/VCO_Gerber.zip 
Project name: VCO_Gerber
/tmp/rename_layers_tmp ~/workspace/gerber_pcbway
Archive:  input.zip
  inflating: TOP.art                 
  inflating: SSTP.art                
  inflating: SSBT.art                
  inflating: SPTP.art                
  inflating: SPBT.art                
  inflating: SMTP.art                
  inflating: SMBT.art                
  inflating: NCLEGEND-1-2.art        
  inflating: nc_param.txt            
  inflating: BOTTOM.art              
  inflating: ASSYTP.art              
  inflating: ASSYBT.art              
  inflating: art_param.txt           
  inflating: vco_collpits-1-2.drl    
  inflating: OUTLINE.art             
  adding: VCO_Gerber.GTL (deflated 73%)
  adding: VCO_Gerber.GBL (deflated 67%)
  adding: VCO_Gerber.GTS (deflated 68%)
  adding: VCO_Gerber.GBS (deflated 60%)
  adding: VCO_Gerber.GTO (deflated 74%)
  adding: VCO_Gerber.GBO (deflated 51%)
  adding: VCO_Gerber.GTP (deflated 65%)
  adding: VCO_Gerber.GBP (deflated 51%)
  adding: VCO_Gerber.GKO (deflated 48%)
  adding: VCO_Gerber_ASSYBT.art (deflated 53%)
  adding: VCO_Gerber_ASSYTP.art (deflated 74%)
  adding: VCO_Gerber_NCLEGEND-1-2.art (deflated 77%)
  adding: VCO_Gerber_art_param.txt (deflated 45%)
  adding: VCO_Gerber_nc_param.txt (deflated 65%)
  adding: VCO_Gerber_vco_collpits-1-2.DRD (deflated 53%)
~/workspace/gerber_pcbway
Created VCO_Gerber_pcbway.zip successfully!
```
The file **VCO_Gerber_pcbway.zip** is ready to be sent to https://pcbway.com.


Don't forget to check it with https://www.pcbway.com/project/OnlineGerberViewer.html before uploading for production.


