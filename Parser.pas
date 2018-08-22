(* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is 3D-Crade
 *
 * The Initial Developer of the Original Code is
 * jyce3d
 *
 * Portions created by the Initial Developer are Copyright (C) 2003-2005
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *
 * ***** END LICENSE BLOCK ***** *)

// Author : Jyce3d
// Unit parser for 3DCrade Scriptor module
// derived from CustomParser
// Implements the specific 3DCrade Scriptor commands.
// 25/03/2005 : Bug fixing

unit Parser;

interface
uses Classes,SysUtils,Context,Scene3D,CustomParser;

type


// Gère toutes les variables du système :
// gestion des lists
// evaluation des valeurs

TCommandPoint=class(TCustomCommand)
 constructor create(StrContent:string;
  Context: TCustomCOntext; Drawer:TDrawer3D;output: TStringList);reintroduce;
end;

TCommandFrame=class(TCustomCommand)
 constructor create(StrContent:string;
 Context:TCustomContext; Drawer:TDrawer3D;output:TStringList);reintroduce;
end;
{TCommandSphere=class(TCustomCommand)
 constructor create(strContent:string;Context:TCustomCOntext;Drawer:TDrawer3D;ouput:TStringList);reintroduce;
end;}


TCommandList3D=class(TCustomCommand)
 constructor create( strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;

end;
TCommandLine=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandMayeEllipse=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandExplode=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandHide=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandUnHide=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;

TCommandMayeSphere=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandMayeEllipsoid=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandMayeBoxFrame=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandMayeCylinder=class(TCustomCommand)
 constructor create(strContent: string;
   context: TCustomContext; Drawer: TDrawer3D; output: TStringList);reintroduce;
end;
TCommandMayeEllipseCLip=class(TCustomCommand)
 constructor create(strContent: string;context: TCustomContext; Drawer: TDrawer3D; output: TStringList);reintroduce;
end;
TCommandMayeArcoid=class(TCustomCommand)
 constructor create(strContent: string;context: TCustomContext; Drawer: TDrawer3D; output: TStringList);reintroduce;
end;
TCommandRemove=class(TCustomCOmmand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandRotate=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;

TCommandRotateX=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandRotateY=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandRotateZ=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;

TCommandTranslate=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;

TCommandCopy=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;

end;
TCommandExtrudeX=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandExtrudeY=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandExtrudeZ=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandRevolutionX=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;

TCommandRevolutionY=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;

TCommandRevolutionZ=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandMayeLine=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandWall=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandWallCorner=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandWallFence=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;
TCommandFence=class(TCustomCommand)
 constructor create(strContent:string;context:TCustomContext; Drawer:TDrawer3D; output:TStringList);reintroduce;
end;

TParser=class(TCustomParser)
 protected
  fDrawer3D:TDrawer3D;
 // function ExtractCommand(str:string;var sCommand,sContent:string):boolean;override;
  function OnExecuteNeutral(str,sCommand,sContent:string):integer;override;
 public

 constructor create(context:TCustomContext;Drawer:TDrawer3D;output:TStringList);reintroduce;
 function Parse(str:string;var sCommand:string;var sContent:string):integer;override;
end;

//function ExtractOpera(oper,str:string;var sLeft,sRight:string):boolean;
//function isOperator(s:string):boolean;


implementation
uses strlib,MayeSurf,CustomTree;
{ TParser }

constructor TParser.create(context: TCustomContext;Drawer:TDrawer3D;output:TStringList);
begin
 inherited create(context,output);
 fDrawer3D:=Drawer;
end;

function TParser.OnExecuteNeutral(str, sCommand,
  sContent: string): integer;
var Scene3D:TScene3D;   sKeyname:string;
begin
 // TODO:Test extra structure commands such as :
 // bloc->blend, surface->surfend
// result:=0;
 if sCommand='block' then
 begin
  // Test si le bloc existe
  if fDrawer3D.fTree3D.GetScene3DRef(sContent,true)=nil then
  begin
   sKeyname:=fContext.EvalString(sContent);
   Scene3D:=fDrawer3D.fTree3D.Add(fDrawer3D.CurrentScene3DRef) as TScene3D;
   Scene3D.Keyname:=sKeyname;
   Scene3D.fParent:=fDrawer3D.CurrentScene3D;
   Scene3D.Drawer3D:=fDrawer3D;
   fDrawer3D.SetCurrentScene3D(Scene3D);
   result:=1;
  end else
   raise Exception.Create('The Scene'+sKeyname+' already exists');
 end else
  if sCommand='blend' then
  begin
   if fDrawer3D.CurrentScene3DRef.fParentNode<>nil then
   begin
    Scene3D:=((fDrawer3D.CurrentScene3DRef.fParentNode as TTreeItemRef).Value as TScene3D);
    fDrawer3D.SetCurrentScene3D(Scene3D);
   end;
   result:=1;
  end else
  begin
   result:=inherited OnExecuteNeutral(str,sCommand,sContent);
   if result=PARSE_NOK then
    raise Exception.Create('Unkonwn command');
  end;

end;

function TParser.Parse(str: string;var sCommand:string;var sContent:string): integer;
var strCommand,strComContent:string;   cmd:TCustomCommand;

begin
 // Trimer
   // sinon commande, rechercher ( et prendre à gauche, identi
   //  Extraire paramètre, en fonction de leur type :
   //                                                 LET (varc,valx,valy,valz)
   //                                                 LET (vart,"text 1")
   //                                                 LET (varc,[SELECT({NEAREST|ENDPOINT|STARTPOINT|CENTER}])
   //                                                    ex:LET (varc,[SELECT(NEAREST)]) => ask for a mouse selection
   //                                                 PRINT (var)
   //                                                 LINE (varc1,varc2[,color,type,keyname])
   //                                                 LINE (x1,y1,z1,varc2[,color,type,keyname])
   //                                                 LINE (varc1,x2,y2,z2[,color,type,keyname])
   //                                                 Line (x1,y1,z1,x2,y2,z2[,color,type,keyname])
   //                                                 LINE@ (rho,teta,phi[,x1,y1,z1,color,type,keyname])
   //                                                 LINE@ (rho,teta,phi[,varc,color,type,keyname])
   //                                                 PLOT (varc,[,color,keyname])


   //                                                 Set (var,type)
   //                                                 Let (var,value)
   //                                                 Point (x,y,z[,color,keyname])
   //                                                 LINE (var,value,var2,value2,value3,value4[,color,type,keyname])
   //                                                 Fame(x,y,z,width,length,height[,color,type,keyname])
   //                                                 _Framebox(x,y,z,width,length,height,nLong,nLat[,color,Type,KeyName])
   //                                                 _Sphere(x,y,z,radius,nLong,nLat[,color,type,keyname])
   //                                                 _Ellipsoid(x,y,z,rx,ry,rz,nLong,nLat[,color,type,keyname])
   //                                                 _Ellipse(x,y,z,a,b,nLong[,color,type,keyname])
   //                                                 _arc(x,y,z,a,b,nLong,phi0,phi1[,color,type,keyname])
   //                                                 _arcoid(x,y,z,rx,ry,rz,phi0,phi1,teta0,teta1[,color,type,keyname])
   //                                                 _cylinder(x,y,z,a,b,height,nLong,nLat[,color,type,keyname])
   //                                                 LIST_var()
   //                                                 List_3D()
   //                                                 KILL (var)
   //                                                 Rotate(teta,x1,y1,z1,x2,y2,z2,Keyname)
   //                                                 RotateX(phi,Keyname)
   //                                                 RotateY(phi,KeyName)
   //                                                 RotateZ(phi,KeyName)
   //                                                 Translate(cx,cy,cz,KeyName)
   //                                                 Copy(KeyName1,KeyName2)
   //
   // Sinon Si Egal
   result:=PARSE_NOK;
   if inherited Parse(str,sCommand,sContent)=PARSE_OK then  begin
    result:=PARSE_OK;
    exit;
   end;
   strCommand:=sCommand;
   strComContent:=sContent;
      if strCommand='point' then begin
       cmd:=TCommandPoint.Create(strComContent,fcontext,fDrawer3D,foutput);
       FreeAndNIl(cmd);
       result:=PARSE_OK;
      end else
       if strCommand='list_3d' then begin
        cmd:=TCommandList3D.Create(strComContent,fcontext,FDrawer3D,foutput);
        FreeAndNIl(cmd);
        Result:=PARSE_OK;
       end else
        if strCommand='line' then begin
         cmd:=TCOmmandLine.create(strComContent,fcontext,FDrawer3D,foutput);
         FreeAndNIl(cmd);
         Result:=PARSE_OK;
        end else
         if strCOmmand='remove' then begin
          cmd:=TCommandRemove.Create(strComContent,fcontext,fDrawer3D,foutput);
          FreeAndNIl(cmd);
          Result:=PARSE_OK;
         end else
           if strcommand='frame' then begin
            cmd:=TCommandFrame.Create(strComContent,fcontext,fDrawer3D,foutput);
            FreeAndNIl(cmd);
            result:=PARSE_OK;
           end else
            if strCommand='_ellipse' then begin
             cmd:=TCommandMayeEllipse.create(strComContent,fcontext,fDrawer3D,foutput);
             FreeAndNIl(cmd);
             result:=PARSE_OK;

            end else
             if strCommand='_sphere' then begin
              cmd:=TCommandMayeSphere.create(strComContent,fcontext,fDrawer3D,foutput);
              FreeAndNIl(cmd);
              result:=PARSE_OK;

             end else
              if strCommand='_ellipsoid' then begin
               cmd:=TCommandMayeEllipsoid.Create(strComContent,fcontext,fDrawer3D,foutput);
               FreeAndNil(cmd);
               result:=PARSE_OK;
              end else
               if strCommand='_framebox' then begin
                cmd:=TCommandMayeboxframe.create(strComContent,fcontext,fDrawer3D,foutput);
                FreeAndNil(cmd);
                result:=PARSE_OK;
               end else
               if strCommand='_cylinder' then begin
                cmd:=TCommandMayeCylinder.Create(strComContent,fcontext,fDrawer3D,foutput);
                FreeAndNil(cmd);
                result:=PARSE_OK;
               end else
                if strCommand='_arc' then begin
                 cmd:=TCommandMayeEllipseClip.Create(strComContent,fcontext,fDrawer3D,foutput);
                 FreeAndNil(cmd);
                 result:=PARSE_OK;
                end else
                 if strCommand='_arcoid' then begin
                  cmd:=TCommandMayeArcoid.Create(strComContent,fcontext,fDrawer3D,foutput);
                  FreeAndNil(cmd);
                  result:=PARSE_OK;
                 end else
                  if strCommand='rotate' then begin
                   cmd:=TCommandRotate.Create(strComContent,fcontext,fDrawer3D,foutput);
                   FreeAndNil(cmd);
                   result:=PARSE_OK;
                  end else
                   if strCommand='copy' then begin
                    cmd:=TCommandCopy.Create(strComContent,fcontext,fDrawer3D,foutput);
                    FreeAndNil(cmd);
                    result:=PARSE_OK;
                   end else
                    if strCommand='translate' then begin
                     cmd:=TCommandTranslate.Create(strComContent,fcontext,fDrawer3D,foutput);
                     FreeAndNil(cmd);
                     result:=PARSE_OK;
                    end else
                     if strCommand='rotatex' then begin
                      cmd:=TCommandRotateX.Create(strComContent,fcontext,fDrawer3D,foutput);
                      FreeAndNil(cmd);
                      result:=PARSE_OK;

                     end  else
                      if strCommand='rotatey' then begin
                       cmd:=TCommandRotateY.Create(strComContent,fcontext,fDrawer3D,foutput);
                       FreeAndNil(cmd);
                       result:=PARSE_OK;

                      end else
                       if strCommand='rotatez' then begin
                        cmd:=TCommandRotatez.Create(strComContent,fcontext,fDrawer3D,foutput);
                        FreeAndNil(cmd);
                        result:=PARSE_OK;

                       end else
                        if strCommand='_extrudex' then begin
                         cmd:=TCommandExtrudex.Create(strComContent,fcontext,fDrawer3D,foutput);
                         FreeAndNil(cmd);
                         result:=PARSE_OK;
                        end else
                         if strCommand='_extrudey' then begin
                          cmd:=TCommandExtrudey.Create(strComContent,fcontext,fDrawer3D,foutput);
                          FreeAndNil(cmd);
                          result:=PARSE_OK;
                         end else
                          if strCommand='_extrudez' then begin
                           cmd:=TCommandExtrudez.Create(strComContent,fcontext,fDrawer3D,foutput);
                           FreeAndNil(cmd);
                           result:=PARSE_OK;
                          end else
                           if strCommand='explode' then begin
                            cmd:=TCommandExplode.Create(strComContent,fcontext,fDrawer3D,foutput);
                            FreeAndNil(cmd);
                            result:=PARSE_OK;
                           end else
                            if strCommand='_revolutionx' then begin
                             cmd:=TCommandRevolutionX.Create(strComContent,fcontext,fDrawer3D,foutput);
                             FreeAndNil(cmd);
                             result:=PARSE_OK;
                            end else

                             if strCommand='_revolutiony' then begin
                              cmd:=TCommandRevolutiony.Create(strComContent,fcontext,fDrawer3D,foutput);
                              FreeAndNil(cmd);
                              result:=PARSE_OK;
                             end else
                              if strCommand='_revolutionz' then begin
                               cmd:=TCommandRevolutionZ.Create(strComContent,fcontext,fDrawer3D,foutput);
                               FreeAndNil(cmd);
                               result:=PARSE_OK;
                              end else
                               if strCommand='_line' then begin
                                cmd:=TCommandMayeLine.Create(strComContent,fContext,fDrawer3D,foutput);
                                FreeAndNil(cmd);
                                result:=PARSE_OK;
                               end else
                                if strCommand='_wall' then begin
                                 cmd:=TCommandWall.Create(strComContent,fContext,fDrawer3D,foutput);
                                 FreeAndNil(cmd);
                                 result:=PARSE_OK;

                                end else
                                 if strCommand='_wallcorner' then begin
                                  cmd:=TCommandWallCorner.Create(strComContent,fContext,fDrawer3D,foutput);
                                  FreeAndNil(cmd);
                                  result:=PARSE_OK;
                                 end else
                                  if strCommand='_wallfence' then begin
                                   cmd:=TCommandWallFence.Create(strComContent,fContext,fDrawer3D,foutput);
                                   FreeAndNil(cmd);
                                   result:=PARSE_OK;
                                  end else
                                   if strCommand='_fence' then begin
                                    cmd:=TCommandFence.Create(strComContent,fContext,fDrawer3D,foutput);
                                    FreeAndNil(cmd);
                                    result:=PARSE_OK;
                                   end else
                                    if strCommand='hide' then begin
                                     cmd:=TCommandHide.Create(strComContent,fContext,fDrawer3D,foutput);
                                     FreeAndNil(cmd);
                                     result:=PARSE_OK;
                                    end else
                                     if strCommand='unhide' then begin
                                      cmd:=TCommandUnhide.Create(strComContent,fContext,fDrawer3D,foutput);
                                      FreeAndNil(cmd);
                                      result:=PARSE_OK;
                                     end;



// TODO: Add your commands here
end;



{ TStructuredVariable }


{ TCommandPlot }



{ TCommandList3D }

constructor TCommandList3D.create(strContent: string;
  context: TCustomContext;Drawer:TDrawer3D; output: TStringList);
var tmpOutput:TStringList; i:integer;

begin
 inherited Create(Context);

 output.Add('3D Items List');
 output.add('=============');

 tmpOutput:=TStringList.Create;
 if strContent<>'' then
 begin
  raise Exception.Create('list does not take arguments');
 end;
 // points
 Drawer.Scene3DTree.GetStringItemList(tmpOutput);
 for i:=0 to tmpoutput.Count -1 do
  output.add(tmpoutput.Strings[i]);
 tmpOutPut.free;

end;
constructor TCommandPoint.create(StrContent:string;
  Context: TCustomCOntext; Drawer:TDrawer3D;output: TStringList);
  var par1,par2,par3,par4,par5,par6,parl:string; pos:integer;   Point3D:TPoint3D;
      Object3DRef:TObject3DRef;
begin
 inherited Create(COntext);
// Detecte le type de variable
// bCoordType:=false;

 par1:=GetFirst(strContent,pos); //x ou bien coord
 par2:=GetNext(strContent,pos);  //y ou bien name
 par3:=GetNext(strContent,pos);  //z ou bien '' si coord
 par4:=GetNext(strContent,pos);  // color
 par5:=GetNext(strContent,pos);  // Type
 par6:=GetNext(strContent,pos);  // keyname ou bien ''
 parl:=GetNext(strContent,pos);  // d'office rien

{ if ((par3='') and (par4='')) then
  bCoordType:=true;
  // tester le cas par ex :(3,,2)
 if ((par2='') and (par3<>'')) then
 begin
  raise Exception.Create('Bad Parameters');
  exit;
 end;

 if not bCoordType then begin}
 if parl<>'' then
  begin
   raise Exception.Create('Bad Parameters');
   exit;
  end;
  if par4='' then
   par4:='0';
  if par5='' then
   par5:='"_default"';
  if par6='' then
  par6:='"Point'+inttostr(Drawer.Point3DList.Count+1)+'"';

  Object3DRef:=Drawer.Scene3DTree.GetPoint3DRef(Context.EvalString(par6),true) as TObject3DRef;
  if Object3DRef<>nil then
   Point3D:=(Object3DRef.Value as TPoint3D) else Point3D:=nil;
  if Point3D=nil then
   Point3D:=Drawer.Scene3DTree.AddPoint3D(nil);

  with Point3D do begin
   x:=Context.EvalFloat(par1);
   y:=Context.EvalFloat(par2);
   z:=Context.EvalFloat(par3);
   color:=Round(fContext.Evalfloat(par4));
   keyname:=Context.EvalString(par6);
   oType:=0;
//   fparent:=Drawer.Scene3D;
  end;

// end else
// begin   // Récupérer les coordonnées d'un point avec une variable de type coord

// end;
end;

{ TCommandLine }

constructor TCommandLine.create(strContent: string;
  context: TCustomContext; Drawer:TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,par6,par7,par8,par9,parl:string;
    pos:integer; Line3D:TLine3D;
    Object3DRef:TObject3DRef;
begin
 inherited Create(COntext);
// Detecte le type de variable
// bCoordType:=false;

 par1:=GetFirst(strContent,pos); //x1 ou bien coord
 par2:=GetNext(strContent,pos);  //y1 ou bien name
 par3:=GetNext(strContent,pos);  //z1 ou bien '' si coord
 par4:=GetNext(strContent,pos);  //x2
 par5:=GetNext(strContent,pos);  //y2
 par6:=GetNext(strContent,pos);  //z2
 par7:=GetNext(strContent,pos);  // color
 par8:=GetNext(strContent,pos);  // Type
 par9:=GetNext(strContent,pos);  // keyname ou bien ''
 parl:=GetNext(strContent,pos);  // d'office rien

 if parl<>'' then
  raise exception.Create('Bad parameters');
 if par7='' then par7:='0';
  if par8='' then
   par8:='"_default"';
 if par9='' then par9:='"Line'+inttostr(Drawer.Line3DList.Count+1)+'"' ;

  Object3DRef:=(Drawer.Scene3DTree.GetLine3DRef(Context.EvalString(par9),true) as TObject3DRef);
  if Object3DRef<>nil  then
   Line3D:=(Object3DRef.Value as TLine3D) else Line3D:=nil;
  if Line3D=nil then
   Line3D:=Drawer.Scene3DTree.AddLine3D(Drawer.CurrentScene3DRef);

  with Line3D do begin
   x1:=Context.EvalFloat(par1);
   y1:=Context.EvalFloat(par2);
   z1:=Context.EvalFloat(par3);
   x2:=Context.EvalFloat(par4);
   y2:=Context.EvalFloat(par5);
   z2:=Context.EvalFloat(par6);
   color:=round(Context.EvalFloat(par7));
   oType:=Drawer.GetTypeObject3D(Context.EvalString(par8));
   keyname:=Context.EvalString(par9);
  end;
end;

{ TCommandRemove }

constructor TCommandRemove.create(strContent: string;
  context: TCustomContext; Drawer:TDrawer3D; output: TStringList);
var par,parl:string;
    pos:integer; key:string;
begin
 inherited Create(COntext);
 par:=GetFirst(strContent,pos); //x1 ou bien coord
 parl:=GetNext(strContent,pos);  //y1 ou bien name
 key:=Context.EvalString(par);
 if parl<>'' then
  raise Exception.Create('Bad line parameter');
 // Search Item to remove it
 Drawer.Scene3DTree.RemoveObject3D(key);
end;

{ TCommandSphere }

{constructor TCommandSphere.create(strContent: string;
  Context: TCustomCOntext; Drawer:TDrawer3D; ouput: TStringList);
var pos:integer;
    par1,par2,par3,par4,par5,par6,par7,par8,parl:string;

begin
 inherited Create(COntext);
 par1:=GetFirst(strContent,pos); //x center
 par2:=GetNext(strContent,pos); //y center
 par3:=GetNext(strContent,pos); //z center
 par4:=GetNext(strContent,pos); // radius
 par5:=GetNext(strContent,pos); // latitude circles
 par6:=GetNext(strContent,pos); // longitude circles
 par7:=GetNext(strContent,pos); // color
 par8:=GetNext(strContent,pos); // keyname
 parl:=GetNext(strContent,pos);

 if parl<>'' then
  raise Exception.Create('Bad line parameter');

 if par7='' then par7:='0';
 if par8='' then par8:='"Sphere'+inttostr(Drawer.Scene3D.fSphere3DList.Count+1)+'"';

  Sphere3D:=Drawer.Scene3D.fSphere3DList.GetByName(Context.EvalString(par8)) as TSphere3D;
  if Sphere3D=nil then
  begin
   Sphere3D:=Drawer.Scene3D.fSphere3DList.Add as TSphere3D;
   Sphere3D.Drawer3D:=Drawer;
  end;
  with Sphere3D do begin
   x:=Context.EvalFloat(par1);
   y:=Context.EvalFloat(par2);
   z:=Context.EvalFloat(par3);
   radius:=Context.EvalFloat(par4);
   LatitudeCircles:=Round(Context.EvalFloat(par5));
   LongitudeCircles:=Round(Context.EvalFloat(par6));
   color:=round(strtofloat(par7));
   keyname:=Context.EvalString(par8);

  end;
end;}

{ TCommandFrame }
// Description
//  Add a frame to the Drawer.Scene3D.FrameList;
// Parameters
//
// Return
//
// Remarks
//

constructor TCommandFrame.create(StrContent: string;
  Context: TCustomContext; Drawer:TDrawer3D; output: TStringList);
var pos:integer;
    par1,par2,par3,par4,par5,par6,par7,par8,par9,parl:string;
    Frame3D:TFrame3D;
    cx,cy,cz,height,width,length:extended;
    Object3DRef:TObject3DRef;
begin
 inherited Create(COntext);
 par1:=GetFirst(strContent,pos); //x1 center
 par2:=GetNext(strContent,pos); //y1 center
 par3:=GetNext(strContent,pos); //z1 center
 par4:=GetNext(strContent,pos); //width
 par5:=GetNext(strContent,pos); //length
 par6:=GetNext(strContent,pos); //height
 par7:=GetNext(strContent,pos); //color
 par8:=GetNext(strContent,pos); //Type
 par9:=GetNext(strContent,pos); //keyname
 parl:=GetNext(strContent,pos);
 if parl<>'' then
  raise Exception.Create('Bad line parameter');

 if par7='' then par7:='0';
 if par8='' then
    par8:='"_default"';

 if par9='' then par9:='"Frame'+inttostr(Drawer.Frame3DList.Count+1)+'"';

  Object3DRef:=Drawer.Scene3DTree.GetFrame3DRef(Context.EvalString(par9),true) as TObject3DRef;
  if Object3DRef<>nil then
  Frame3D:=(Object3DRef.Value as TFrame3D) else Frame3D:=nil;
  if Frame3D=nil then
   Frame3D:=Drawer.Scene3DTree.AddFrame3D(Drawer.CurrentScene3DRef) else
    Frame3D.Clear;



    cx:=Context.EvalFloat(par1);
    cy:=COntext.EvalFloat(par2);
    cz:=Context.EvalFloat(par3);
    width:=Context.EvalFloat(par4);
    length:=COntext.EValFloat(par5);
    height:=COntext.EvalFloat(par6);
  with Frame3D do begin
    color:=round(Context.EvalFloat(par7));
    oType:=Drawer.GetTypeObject3D(Context.EvalString(par8));
    keyname:=Context.EvalString(par9);
 //   fParent:=Drawer.Scene3D;
  end;

  CreateFrame(Frame3D,cx,cy,cz,height,length,width,Frame3D.color,Frame3D.otype,Frame3D.keyname,Drawer.Scene3D,Drawer);

end;

{ TCommandEllipse }
// Description
// Add an Ellipse to the Drawer3D.Ellipse3DList collection
// Parameters
// x,y,z : left bottom point of the ellipse
// width : width of the ellipse (bottom to top) (X)
// length : length of the ellipse (left to right)  (Y)
// height : height of the ellipse                  (Z)
// Return
//
// Remarks
//
{constructor TCommandEllipse.create(StrContent: string;
  Context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,par6,par7,par8,parl:string;
    pos:integer;
    Ellipse3D:TEllipse3D;
begin
 inherited Create(COntext);
 par1:=GetFirst(strContent,pos); //x1 center
 par2:=GetNext(strContent,pos); //y1 center
 par3:=GetNext(strContent,pos); //z1 center
 par4:=GetNext(strContent,pos); //xmax
 par5:=GetNext(strContent,pos); //ymax
 par6:=GetNext(strContent,pos); //zmax
 par7:=GetNext(strContent,pos); //color
 par8:=GetNext(strContent,pos); //keyname
 parl:=GetNext(strContent,pos);
 if parl<>'' then
  raise Exception.Create('Bad line parameter');

 if par7='' then par7:='0';
 if par8='' then par8:='"Ellipse'+inttostr(Drawer.Scene3D.fEllipse3DList.Count+1)+'"';

  Ellipse3D:=Drawer.Scene3D.fEllipse3DList.GetByName(Context.EvalString(par8)) as TEllipse3D;
  if Ellipse3D=nil then
  begin
   Ellipse3D:=Drawer.Scene3D.fEllipse3DList.Add as TEllipse3D;
// Always must be done
   Ellipse3D.Drawer3D:
   =Drawer;
  end;
  with Ellipse3D do begin
    x:=Context.EvalFloat(par1);
    y:=Context.EvalFloat(par2);
    z:=Context.EvalFloat(par3);
    xmax:=Context.EvalFloat(par4);
    ymax:=Context.EvalFloat(par5);
    zmax:=Context.EvalFloat(par6);
    color:=round(Context.EvalFloat(par7));
    keyname:=Context.EvalString(par8);
  end;

end;}

{ TCommandMayeEllipse }

constructor TCommandMayeEllipse.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
  var par1,par2,par3,par4,par5,par6,par7,par8, par9,parl:string;
      MayeEllipse : TMayeSurface3D; pos:integer; MayeTriList:TMayeTriFace3DList; Tri:TMayeTriFace3D;
      a,b,teta,deltateta : extended; seg:TMayeEdge;
      cx,cy,cz:extended;   i:integer;
      px,py,pz:extended;
      Object3DRef:TObject3DRef;
begin

 inherited Create(COntext);

 par1:=GetFirst(strContent,pos); //xc ou bien coord
 par2:=GetNext(strContent,pos);  //yc ou bien name
 par3:=GetNext(strContent,pos);  //zc ou bien '' si coord
 par4:=GetNext(strContent,pos);  // a
 par5:=GetNext(strContent,pos);  // b
 par6:=GetNext(strContent,pos);  // nPt
 par7:=GetNext(strContent,pos);  // color
 par8:=GetNext(strContent,pos); //Type
 par9:=GetNext(strContent,pos);  // key name
 parl:=GetNext(strContent,pos);

 if parl<>'' then
  raise Exception.Create('Bad line parameter');
 if par7='' then par7:='0';
 if par8='' then
    par8:='"_default"';
 if par9='' then par9:='"_Ellipse'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';

 Object3DRef:=(Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par9),true) as TObject3DRef);
 if Object3DRef<>nil then
 MayeEllipse:=(Object3DRef.Value as TMayeSurface3D) else MayeEllipse:=nil;
  if MayeEllipse=nil then
   MayeEllipse:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3DRef) else
    MayeEllipse.Clear;

 cx:=Context.EvalFloat(par1);
 cy:=Context.EvalFloat(par2);
 cz:=Context.EvalFloat(par3);

 a:=Context.EvalFloat(par4);
 b:=Context.EvalFloat(par5);

 with MayeEllipse do begin
  nLong:=round(Context.EvalFloat(par6));
  nLat:=0;
  color:=round(Context.EvalFloat(par7));
  oType:=Drawer.GetTypeObject3D(Context.EvalString(par8));

  keyname:=Context.EvalString(par9);
//  fparent:=Drawer.Scene3D;
 end;
 if MayeEllipse.oType=DRAWTYPE_DEFAULT then
 CreateMayeEllipse(MayeEllipse,cx,cy,cz,a,b) else
  if MayeEllipse.OType=DRAWTYPE_SOLID then
   CreateMayeSolidEllipse(MayeEllipse,cx,cy,cz,a,b);
 // construction du mayage de l'ellipse;
end;

{ TCommandMayeSphere }

constructor TCommandMayeSphere.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,par6,par7,par8, par9,par10, parl:string;
    MayeSphere:TMayeSurface3D;
    cx,cy,cz,r,teta,phi,deltateta,deltaphi:extended;
    pos,i,j:integer;
    px,py,pz:extended;
    MayeTriList:TMayeTriFace3DList; Tri:TMayeTriFace3D;
    Seg:TMayeEdge;
    Object3DRef:TObject3DRef;
 procedure CalcSphere(var px,py,pz:extended);
 begin
  px:=r*sin(teta)*cos(phi)+cx;
  py:=r*sin(teta)*sin(phi)+cy;
  pz:=r*cos(teta)+cz;
 end;
begin
 par1:=GetFirst(strContent,pos); //xc ou bien coord
 par2:=GetNext(strContent,pos);  //yc ou bien name
 par3:=GetNext(strContent,pos);  //zc ou bien '' si coord
 par4:=GetNext(strContent,pos);  // r
 par5:=GetNext(strContent,pos);  // nPt Long
 par6:=GetNext(strContent,pos);  // nPt Lat
 par7:=GetNext(strContent,pos);  // color
 par8:=GetNext(strContent,pos);  // oType
 par9:=GetNext(strContent,pos);  // Transparent
 par10:=GetNext(strContent,pos);  // key name
 parl:=GetNext(strContent,pos);

 if parl<>'' then
  raise Exception.Create('Bad line parameter');

 if par7='' then par7:='0';
 if par8='' then par8:='"_default"';
 if par9='' then par9:='0';
 if par10='' then par10:='"_Sphere'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';

 Object3DRef:=(Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par10),true) as TObject3DRef);
 if Object3DRef<>nil then
  MayeSphere:=(Object3DRef.Value as TMayeSurface3D) else MayeSphere:=nil;
  if MayeSphere=nil then
   MAyeSphere:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3DRef) else
    MayeSphere.Clear;


 cx:=Context.EvalFloat(par1);
 cy:=Context.EvalFloat(par2);
 cz:=Context.EvalFloat(par3);

 r:=Context.EvalFloat(par4);

 with MayeSphere do begin
  nLong:=round(Context.EvalFloat(par5));
  nLat:=round(Context.EvalFloat(par6));
  color:=round(Context.EvalFloat(par7));
  oType:=Drawer.GetTypeObject3D(Context.EvalString(par8));
  nTransparent:=Round(Context.EvalFLoat(par9));
  keyname:=Context.EvalString(par10);
//  fParent:=Drawer.Scene3D;
 end;

 phi:=0; teta:=pi; //(modif)
 deltaphi:=2*pi/MayeSphere.nLong; deltateta:=pi/MayeSphere.nLat;

 MayeTriList:=MayeSphere.fMayeTriFace3DList;
 for j:=1 to MayeSphere.nLat do begin
//j:=1;
   for i:=1 to MayeSphere.nLong  do begin
    Tri:=MayeTriList.Add as TMayeTriFace3D;
    Tri.KeyName:=MayeSphere.KeyName+'_'+inttostr(i)+';'+inttostr(j);
    Tri.Color:=MayeSphere.Color;
    Tri.oType:=MayeSphere.oType;
    Tri.fParent:=MayeSphere.fParent;
    Tri.nTransparent:=MayeSphere.nTransparent;
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    CalcSphere(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;
    Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;

    teta:=teta-deltateta;
    CalcSphere(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;
    //3ème
    Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
    teta:=teta+deltateta;
    phi:=phi+deltaphi;
    CalcSphere(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;
    // 4ème
    teta:=teta-deltateta;
    Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
    CalcSphere(px,py,pz);
    teta:=teta+deltateta;
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;

    // end Added
{    if not((j=MayeSphere.nLat) and (i=MayeSphere.nLong)) then begin
     Seg.x:=px; Seg.y:=py; Seg.z:=pz;
     Tri:=MayeTriList.Add as TMayeTriFace3D;
     Tri.KeyName:=MayeSphere.KeyName+'_'+inttostr(i)+';'+inttostr(j);
     seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
     Seg.x:=olx; Seg.y:=oly; Seg.z:=olz;
     seg:=Tri.fMayeEdgeList.Add as TMayeEdge;}

 //   end;
   end;
   teta:=teta-deltateta;
 end;
end;

{ TCommandMayeEllipsoid }

constructor TCommandMayeEllipsoid.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,par6,par7,par8,par9,par10,par11,par12,parl:string;
    rx,ry,rz,cx,cy,cz,phi,teta,deltateta,deltaphi,px,py,pz:extended;
    pos,i,j:integer;
    MayeEllipsoid:TMayeSurface3D;
    MayeTriList:TMayeTriFace3DList;
    Tri : TMayeTriFace3D;
    Seg : TMayeEdge;
    Object3DRef:TObject3DRef;
 procedure CalcEllipsoid(var px,py,pz:extended);
 begin
  px:=rx*sin(teta)*cos(phi)+cx;
  py:=ry*sin(teta)*sin(phi)+cy;
  pz:=rz*cos(teta)+cz;
 end;

begin
 par1:=GetFirst(strContent,pos); //xc ou bien coord
 par2:=GetNext(strContent,pos);  //yc ou bien name
 par3:=GetNext(strContent,pos);  //zc ou bien '' si coord
 par4:=GetNext(strContent,pos);  // rx
 par5:=GetNext(strContent,pos);  // ry
 par6:=GetNext(strContent,pos);  // rz
 par7:=GetNext(strContent,pos);  // nPt Long
 par8:=GetNext(strContent,pos);  // nPt Lat
 par9:=GetNext(strContent,pos);  // color
 par10:=GetNext(strContent,pos); // oType
 par11:=GetNext(strContent,pos); // Transparent
 par12:=GetNext(strContent,pos);  // key name
 parl:=GetNext(strContent,pos);

 if parl<>'' then
  raise Exception.Create('Bad line parameter');

 if par9='' then par9:='0';
 if par12='' then par12:='"_Ellipsoid'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';

 Object3DRef:=(Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par12),true) as TObject3DRef);
 if Object3DRef<>nil then
  MayeEllipsoid:=(Object3DRef.Value as TMayeSurface3D) else MayeEllipsoid:=nil;

 if MayeEllipsoid=nil then
   MayeEllipsoid:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3DRef) else
    MayeEllipsoid.Clear;


  cx:=Context.EvalFloat(par1);
  cy:=Context.EvalFloat(par2);
  cz:=Context.EvalFloat(par3);

  rx:=Context.EvalFloat(par4);
  ry:=Context.EvalFloat(par5);
  rz:=Context.EvalFloat(par6);

  with MayeEllipsoid do begin
   nLong:=round(Context.EvalFloat(par7));
   nLat:=round(Context.EvalFloat(par8));
   color:=round(Context.EvalFloat(par9));
   oType:=Drawer.GetTypeObject3D(Context.EvalString(par10));
   nTransparent:=round(Context.EvalFloat(par11));
   keyname:=Context.EvalString(par12);
//   fparent:=Drawer.Scene3D;
  end;
 phi:=0; teta:=pi;
 deltaphi:=2*pi/MayeEllipsoid.nLong; deltateta:=pi/MayeEllipsoid.nLat;

 for j:=1 to MayeEllipsoid.nLat do begin
   for i:=1 to MayeEllipsoid.nLong do begin
    MayeTriList:=MayeEllipsoid.fMayeTriFace3DList;
    Tri:=MayeTriList.Add as TMayeTriFace3D;
    Tri.KeyName:=MayeEllipsoid.KeyName+'_'+inttostr(i)+';'+inttostr(j);
    Tri.Color:=MayeEllipsoid.color;
    Tri.oType:=MayeEllipsoid.oType;
    Tri.fparent:=MayeEllipsoid.fparent;
    Tri.nTransparent:=MayeEllipsoid.nTransparent;
    // First
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    CalcEllipsoid(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;
    // Second
    Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
    teta:=teta-deltateta;
    CalcEllipsoid(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;
    // Third
    Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
    teta:=teta+deltateta;
    phi:=phi+deltaphi;
    CalcEllipsoid(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;
    // Added
    teta:=teta-deltateta;
    Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
    CalcEllipsoid(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;

    teta:=teta+deltateta;
   end;
   teta:=teta-deltateta;
 end;

end;

{ TCommandMayeBoxFrame }

constructor TCommandMayeBoxFrame.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,par6,par7,par8,par9,par10,par11,par12,parl:string;
    width,length,height,cx,cy,cz:extended;
    pos:integer;
    MayeFramebox:TMayeSurface3D;
    Object3DRef:TObject3DRef;

begin
 par1:=GetFirst(strContent,pos); //xc ou bien coord
 par2:=GetNext(strContent,pos);  //yc ou bien name
 par3:=GetNext(strContent,pos);  //zc ou bien '' si coord
 par4:=GetNext(strContent,pos);  // width
 par5:=GetNext(strContent,pos);  // length
 par6:=GetNext(strContent,pos);  // height
 par7:=GetNext(strContent,pos);  // nPt Long
 par8:=GetNext(strContent,pos);  // nPt Lat
 par9:=GetNext(strContent,pos);  // color
 par10:=GetNext(strContent,pos); // oType
 par11:=GetNext(strContent,pos); // Transparent
 par12:=GetNext(strContent,pos);  // key name
 parl:=GetNext(strContent,pos);

 if parl<>'' then
  raise Exception.Create('Bad line parameter');

 if par9='' then par9:='0';
 if par12='' then par12:='"_Framebox'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';

 Object3DRef:=Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par12),true) as TObject3DRef;
 if Object3DRef<>nil then
  MayeFrameBox:=(Object3DRef.Value as TMayeSurface3D) else MayeFrameBox:=nil;
  if MayeFrameBox=nil then
   MayeFrameBox:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3DRef) else
    MayeFrameBox.Clear;

  cx:=Context.EvalFloat(par1);
  cy:=Context.EvalFloat(par2);
  cz:=Context.EvalFloat(par3);

  width:=Context.EvalFloat(par4);
  length:=Context.EvalFloat(par5);
  height:=Context.EvalFloat(par6);

  with MayeFramebox do begin
   nLong:=round(Context.EvalFloat(par7));
   nLat:=round(Context.EvalFloat(par8));
   color:=round(Context.EvalFloat(par9));
   keyname:=Context.EvalString(par12);
   oType:=Drawer.GetTypeObject3D(Context.EvalString(par10));
   nTransparent:=Round(Context.EvalFloat(par11));
   fParent:=Drawer.Scene3D;
  end;
//TODO:Add the functon call
 CreateMayeFramebox(MayeFramebox,cx,cy,cz,width,length,height);

end;

constructor TCommandMayeCylinder.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,par6,par7,par8,par9,par10,par11,par12,parl:string;
    a,b,height,cx,cy,cz,phi,deltaz,deltaphi,px,py,pz:extended;
    pos,i,j:integer;
    MayeCylinder:TMayeSurface3D;
    MayeTriList:TMayeTriFace3DList;
    Tri : TMayeTriFace3D;
    Seg : TMayeEdge;
    Object3DRef:TObject3DRef;
 procedure CalcCylinder(var px,py,pz:extended);
 begin
  px:=a*cos(phi)+cx;
  py:=b*sin(phi)+cy;
  pz:=pz;
 end;

begin
 par1:=GetFirst(strContent,pos); //xc ou bien coord
 par2:=GetNext(strContent,pos);  //yc ou bien name
 par3:=GetNext(strContent,pos);  //zc ou bien '' si coord
 par4:=GetNext(strContent,pos);  // a
 par5:=GetNext(strContent,pos);  // b
 par6:=GetNext(strContent,pos);  // height
 par7:=GetNext(strContent,pos);  // nPt Long
 par8:=GetNext(strContent,pos);  // nPt Lat
 par9:=GetNext(strContent,pos);  // color
 par10:=GetNext(strContent,pos); // oType
 par11:=GetNext(strContent,pos); // Transparent
 par12:=GetNext(strContent,pos);  // key name
 parl:=GetNext(strContent,pos);

 if parl<>'' then
  raise Exception.Create('Bad line parameter');

 if par9='' then par9:='0';
 if par12='' then par12:='"_Cylinder'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';

  Object3DRef:=(Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par12),true) as TObject3DRef);
  if Object3DRef<>nil then
   MayeCylinder:=(Object3DRef.Value as TMayeSurface3D) else MayeCylinder:=nil;
  if MayeCylinder=nil then
   MayeCylinder:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3DRef) else
    MayeCylinder.Clear;

  cx:=Context.EvalFloat(par1);
  cy:=Context.EvalFloat(par2);
  cz:=Context.EvalFloat(par3);

  a:=Context.EvalFloat(par4);
  b:=Context.EvalFloat(par5);
  height:=Context.EvalFloat(par6);

  with MayeCylinder do begin
   nLong:=round(Context.EvalFloat(par7));
   nLat:=round(Context.EvalFloat(par8));
   color:=round(Context.EvalFloat(par9));
   oType:=Drawer.GetTypeObject3D(Context.EvalString(par10));
   nTransparent:=round(Context.EvalFloat(par11));
   keyname:=Context.EvalString(par12);
//   fParent:=Drawer.Scene3D;
  end;
 phi:=0; pz:=cz;
 deltaphi:=2*pi/MayeCylinder.nLong; deltaz:=height/MayeCylinder.nLat;

 for j:=1 to MayeCylinder.nLat do begin
   for i:=1 to MayeCylinder.nLong do begin
    MayeTriList:=MayeCylinder.fMayeTriFace3DList;
    Tri:=MayeTriList.Add as TMayeTriFace3D;
    Tri.KeyName:=MayeCylinder.KeyName+'_'+inttostr(i)+';'+inttostr(j);
    Tri.Color:=MayeCylinder.color;
    Tri.oType:=MayeCylinder.oType;
    Tri.fParent:=MayeCylinder.fParent;
    Tri.nTransparent:=MayeCylinder.nTransparent;
    // First
    Seg:=Tri.fMayeEdgeList.Add as TMayeEdge;
    CalcCylinder(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;
    // Second
    Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
    pz:=pz+deltaz;
    CalcCylinder(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;
    // Third
    Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
    pz:=pz-deltaz;
    phi:=phi+deltaphi;
    CalcCylinder(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;
    // Added
    pz:=pz+deltaz;
    Seg:=Tri.FMayeEdgeList.Add as TMayeEdge;
    CalcCylinder(px,py,pz);
    Seg.x:=px; Seg.y:=py; Seg.z:=pz;

    pz:=pz-deltaz;
    // end Added
   end;
   pz:=pz+deltaz;
 end;

end;



{ TCommandMayeEllipseCLip }

constructor TCommandMayeEllipseCLip.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,par6,par7,par8,par9,par10,par11,parl:string;
    cx,cy,cz,a,b,phi0,phi1:extended;
    MayeEllipseClip:TMayeSurface3D;
    pos:integer;
    Object3DRef:TObject3DRef;
begin

 par1:=GetFirst(strContent,pos); //xc ou bien coord
 par2:=GetNext(strContent,pos);  //yc ou bien name
 par3:=GetNext(strContent,pos);  //zc ou bien '' si coord
 par4:=GetNext(strContent,pos);  // a
 par5:=GetNext(strContent,pos);  // b
 par6:=GetNext(strContent,pos);  // nPt
 par7:=GetNext(strContent,pos);  // ph0
 par8:=GetNext(strContent,pos); // phi1
 par9:=GetNext(strContent,pos);  // color
 par10:=GetNext(strContent,pos); // oType
 par11:=GetNext(strContent,pos);  // key name
 parl:=GetNext(strContent,pos);

 if parl<>'' then
  raise Exception.Create('Bad line parameter');

 if par9='' then par9:='0';
 if par11='' then par11:='"_Arc'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';

 Object3DRef:=(Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par11),true) as TObject3DRef);
 if Object3DRef<>nil then
   MayeEllipseClip:=(Object3DRef.Value as TMayeSurface3D) else
    MayeEllipseClip:=nil;

 if MayeEllipseClip=nil then
   MayeEllipseClip:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3DRef) else
    MayeEllipseClip.Clear;

  cx:=Context.EvalFloat(par1);
  cy:=Context.EvalFloat(par2);
  cz:=Context.EvalFloat(par3);

  a:=Context.EvalFloat(par4);
  b:=Context.EvalFloat(par5);
  phi0:=Context.EvalFloat(par7);
  phi1:=Context.EvalFloat(par8);

  with MayeEllipseClip do begin
   nLong:=round(Context.EvalFloat(par6));
   nLat:=0;
   color:=round(Context.EvalFloat(par9));
   oType:=Drawer.GetTypeObject3D(Context.EvalString(par10));
   keyname:=Context.EvalString(par11);
//   fparent:=Drawer.Scene3D;
  end;

  CreateMayeEllipseClip(MayeEllipseClip,cx,cy,cz,a,b,phi0,phi1);
end;

{ TCommandMayeArcoid }

constructor TCommandMayeArcoid.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,par6,par7,par8,par9,par10,par11,par12,par13,par14,par15,par16,parl:string;
    cx,cy,cz,teta0,teta1,phi0,phi1,rx,ry,rz:extended;
    MayeArcoid:TMayeSurface3D;
    pos:integer;
    Object3DRef:TObject3DRef;

begin
 par1:=GetFirst(strContent,pos); //xc ou bien coord
 par2:=GetNext(strContent,pos);  //yc ou bien name
 par3:=GetNext(strContent,pos);  //zc ou bien '' si coord
 par4:=GetNext(strContent,pos);  // rx
 par5:=GetNext(strContent,pos);  // ry
 par6:=GetNext(strContent,pos);  // rz
 par7:=GetNext(strContent,pos);  // nPt Long
 par8:=GetNext(strContent,pos);  // nPt Lat
 par9:=GetNext(strContent,pos);  // phi0
 par10:=GetNext(strContent,pos); // phi1
 par11:=GetNext(strContent,pos); // teta0
 par12:=GetNext(strContent,pos); // teta1
 par13:=GetNext(strContent,pos);  // color
 par14:=GetNext(strContent,pos); // oType
 par15:=GetNext(strContent,pos); // Transparent
 par16:=GetNext(strContent,pos);  // key name
 parl:=GetNext(strContent,pos);

 if parl<>'' then
  raise Exception.Create('Bad line parameter');

 if par13='' then par13:='0';
 if par16='' then par16:='"_Arcoid'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';

 Object3DRef:=Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par16),true) as TObject3DRef;
 if Object3DRef<>nil then
 MayeArcoid:=(Object3DRef.Value as TMayeSurface3D) else MayeArcoid:=nil;
  if MayeArcoid=nil then
   MayeArcoid:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3DRef) else
    MayeArcoid.Clear;

  cx:=Context.EvalFloat(par1);
  cy:=Context.EvalFloat(par2);
  cz:=Context.EvalFloat(par3);

  rx:=Context.EvalFloat(par4);
  ry:=Context.EvalFloat(par5);
  rz:=Context.EvalFloat(par6);

  phi0:=Context.EvalFloat(par9);
  phi1:=Context.EvalFloat(par10);
  teta0:=Context.EvalFloat(par11);
  teta1:=Context.EvalFloat(par12);

  with MayeArcoid do begin
   nLong:=round(Context.EvalFloat(par7));
   nLat:=round(Context.EvalFloat(par8));
   color:=round(Context.EvalFloat(par13));
   oType:=Drawer.GetTypeObject3D(Context.EvalString(par14));
   nTransparent:=round(Context.EvalFloat(par15));
   keyname:=Context.EvalString(par16);
//   fParent:=Drawer.Scene3D;
  end;
  CreateMayeArcoid(MayeArcoid,cx,cy,cz,rx,ry,rz,phi0,phi1,teta0,teta1);
end;

{ TCommandRotate }

constructor TCommandRotate.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,parl:string;
    Object3D:TObject3D;
    phi,teta:extended;
    pos : integer;
begin
 par1:=GetFirst(strContent,pos); //delta teta
 par2:=GetNext(strContent,pos);  //delta phi
 par3:=GetNext(strContent,pos);  //nom
 parl:=GetNext(strContent,pos);  // vide

 if parl<>'' then
  raise Exception.Create('Bad line parameter');

  Object3D:=Drawer.Scene3DTree.GetObject3DRef(Context.EvalString(par3),true).Value;
  if Object3D=nil then
   raise exception.create('TCommandRotate.Create::This object3D does not exist in the scene');

  phi:=Context.evalfloat(par2);
  teta:=Context.evalFloat(par1);

  Object3D.Rotate(teta,phi);

end;

{ TCommandRotateX }

constructor TCommandRotateX.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,parl:string;
    Object3D:TObject3D;
    Object3DRef:TObject3DRef;
    pos : integer;
    Scene3DRef:TTreeItemRef;
    sKeyname:string;
begin
 par1:=GetFirst(strContent,pos); //delta teta
 par2:=GetNext(strContent,pos);  //delta phi
 parl:=GetNext(strContent,pos);  // vide

 if parl<>'' then
  raise Exception.Create('Bad line parameter');
 sKeyname:=Context.EvalString(par2);
 Scene3DRef:=Drawer.Scene3DTree.GetScene3DRef(sKeyname,true);
 if Scene3DRef=nil then begin
   Object3DRef:=Drawer.Scene3DTree.GetObject3DRef(sKeyname,true);
   if Object3DRef<>nil then
   Object3D:=Object3DRef.value else Object3D:=nil;
   if Object3D=nil then
    raise exception.create('TCommandRotate.Create::This object3D does not exist in the scene');

   Object3D.RotateX(Context.EvalFloat(par1));
  end else
  begin
   Object3D:=Scene3DRef.Value as TScene3D;
   if Object3D=nil then
       raise exception.create('TCommandRotate.Create::This object3D does not exist in the scene');
   Object3D.RotateX(Context.EvalFloat(par1));
  end;
end;

{ TCommandRotateY }

constructor TCommandRotateY.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,parl:string;
    Object3D:TObject3D;
    Object3DRef:TObject3DRef;
    pos : integer;
    sKeyname:string;
    Scene3DRef:TTreeItemRef;
begin
 par1:=GetFirst(strContent,pos); //delta phi or teta
 par2:=GetNext(strContent,pos);  //Objectname
 parl:=GetNext(strContent,pos);  // vide

 if parl<>'' then
  raise Exception.Create('Bad line parameter');
 sKeyname:=Context.EvalString(par2);
 Scene3DRef:=Drawer.Scene3DTree.GetScene3DRef(sKeyname,true);
 if Scene3DRef=nil then begin
   Object3DRef:=Drawer.Scene3DTree.GetObject3DRef(sKeyname,true);
   if Object3DRef<>nil then
   Object3D:=Object3DRef.value else Object3D:=nil;
   if Object3D=nil then
    raise exception.create('TCommandRotate.Create::This object3D does not exist in the scene');

   Object3D.RotateY(Context.EvalFloat(par1));
  end else
  begin
   Object3D:=Scene3DRef.Value as TScene3D;
   if Object3D=nil then
       raise exception.create('TCommandRotate.Create::This object3D does not exist in the scene');
   Object3D.RotateY(Context.EvalFloat(par1));
  end;
end;

{ TCommandRotateZ }

constructor TCommandRotateZ.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,parl:string;
    Object3D:TObject3D;
    Object3DRef:TObject3DRef;
    pos : integer;
    sKeyname:string;
    Scene3DRef:TTreeItemRef;
begin
 par1:=GetFirst(strContent,pos); //delta teta
 par2:=GetNext(strContent,pos);  //delta phi
 parl:=GetNext(strContent,pos);  // vide

 if parl<>'' then
  raise Exception.Create('Bad line parameter');

 sKeyname:=Context.EvalString(par2);
 Scene3DRef:=Drawer.Scene3DTree.GetScene3DRef(sKeyname,true);
 if Scene3DRef=nil then begin
   Object3DRef:=Drawer.Scene3DTree.GetObject3DRef(sKeyname,true);
   if Object3DRef<>nil then
   Object3D:=Object3DRef.value else Object3D:=nil;
   if Object3D=nil then
    raise exception.create('TCommandRotate.Create::This object3D does not exist in the scene');

   Object3D.RotateZ(Context.EvalFloat(par1));
  end else
  begin
   Object3D:=Scene3DRef.Value as TScene3D;
   if Object3D=nil then
       raise exception.create('TCommandRotate.Create::This object3D does not exist in the scene');
   Object3D.RotateZ(Context.EvalFloat(par1));
  end;
end;

{ TCommandTranslate }

constructor TCommandTranslate.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,parl:string;
    Object3D:TObject3D;
    Object3DRef:TObject3DRef;
    cx,cy,cz : extended;
    pos : integer;
    sKeyname:String;
    Scene3DRef:TTreeItemRef;
begin
 par1:=GetFirst(strContent,pos); //cx
 par2:=GetNext(strContent,pos);  //cy
 par3:=GetNext(strContent,pos);  //cz
 par4:=GetNext(strContent,pos);  // keyname

 parl:=GetNext(strContent,pos);  // vide

 if parl<>'' then
  raise Exception.Create('Bad line parameter');

  sKeyname:=Context.EvalString(par4);
  Scene3DRef:=Drawer.Scene3DTree.GetScene3DRef(sKeyname,true);
  if Scene3DRef=nil then begin
   Object3DRef:=Drawer.Scene3DTree.GetObject3DRef(sKeyname,true);
   if Object3DRef<>nil then
    Object3D:=Object3DRef.value else Object3D:=nil;
   if Object3D=nil then
    raise exception.create('TCommandTranslate.Create::This object3D does not exist in the scene');
  end else
  begin
   Object3D:=Scene3DRef.Value as TScene3D;
   if Object3D=nil then
    raise exception.create('TCommandTranslate.Create::This object3D does not exist in the scene');

  end;
  cx:=Context.EvalFloat(par1);
  cy:=Context.EvalFloat(par2);
  cz:=Context.EvalFloat(par3);
  Object3D.Translate(cx,cy,cz);
end;

{ TCommandCopy }

constructor TCommandCopy.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,parl:string;
    Object3DSource:TObject3D;
    Object3DTarget:TObject3D;
    pos : integer;
    Object3DRef:TObject3DRef;
    Scene3DRef:TTreeItemRef;
    sSource,sTarget:string;
begin
 par1:=GetFirst(strContent,pos); //SourceObject Name
 par2:=GetNext(strContent,pos);  //TargetObject Name
 parl:=GetNext(strContent,pos);  // vide

 if parl<>'' then
  raise Exception.Create('Bad line parameter');
 sSource:=Context.EvalString(par1);
 sTarget:=Context.EvalString(par2);
 Scene3DRef:=Drawer.Scene3DTree.GetScene3DRef(sSource,true);
 if Scene3DRef=nil then begin  // Copie d'un objet
  Object3DRef:=Drawer.Scene3DTree.GetObject3DRef(sSource,true);
  if Object3DRef<>nil then
   Object3DSource:=Object3DRef.value else Object3DSource:=nil;
  if Object3DSource=nil then
   raise exception.create('TCommandCopy.Create::This object3D does not exist in the scene');
  Scene3DRef:=Drawer.Scene3DTree.GetScene3DRef(sTarget,true);
  if Scene3DRef<>nil then
   raise Exception.Create('TCommandCopy::Create:You cannot copy an object as a Scene3D');

  Object3DRef:=Drawer.Scene3DTree.GetObject3DRef(sTarget,true);
  if Object3DRef<>nil then
  Object3DTarget:=Object3DRef.value else Object3DTarget:=nil;
  if Object3DTarget<>nil then
   Object3DTarget.free;

  Object3DTarget:=Drawer.fTree3D.AddObject3D(Object3DSource,Drawer.fTree3D.GetScene3DRef(Object3DSource.fparent.keyname,true,nil));

  Object3DTarget.KeyName:=sTarget;
 end else
 begin                                 // Copie d'une scène
  Object3DSource:=(Scene3DRef.value as TObject3D);
  if Object3DSource=nil then
   raise exception.create('TCommandCopy.Create::This object3D does not exist in the scene');
  Scene3DRef:=Drawer.Scene3DTree.GetScene3DRef(sTarget,true);
  if Scene3DRef<>nil then
   Object3DTarget:=Scene3DRef.value as TObject3D else Object3DTarget:=nil;
   if Object3DTarget=nil then
   begin
     Object3DTarget:=Drawer.fTree3D.Add(Drawer.CurrentScene3DRef) as TObject3D;
     Object3DTarget.fParent:=Drawer.CurrentScene3D;
     Object3DTarget.Drawer3D:=Drawer;
   end;
   Object3DTarget.KeyName:=sTarget;

   (Object3DTarget as TScene3D).Copy(Object3DSource as TScene3D);

 end;
end;

{ TCommandExtrudeX }

constructor TCommandExtrudeX.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,parl:string;
    Obj3D,MayeExtruded:TObject3D;MayeExtrudedRef:TObject3DRef;
    pos:integer;

begin
 par1:=GetFirst(strContent,pos); //MayeSurface or blocname
 par2:=GetNext(strContent,pos);  // Abs Position or Translation
 par3:=GetNext(strContent,pos);  // nLong : number of maye for extrusion
 par4:=GetNext(strContent,pos);  // Type (0 - Translation,1-Absolute Position)
 par5:=GetNext(strContent,pos);  // KeyName of the extruded surface
 parl:=GetNext(strContent,pos);  // vide

 if parl<>'' then
  raise Exception.Create('Bad line parameter');
 Obj3D:=Drawer.Scene3DTree.GetObject3DRef(Context.EvalString(par1),true).Value;

 if par4='' then
  par4:='0';
 if par5='' then
  par5:='"_ExtrudedX'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';
 if Obj3D=nil then
   raise exception.create('TCommandExtrudeX.Create::This object3D does not exist in the scene.');
 if not(obj3D is TMayeSurface3D) then
  raise Exception.Create('TCommandExtrudeX.Create::This object3D must be a TMayeSurface3D.');

  MayeExtrudedRef:=(Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par5),true) as TObject3DRef);
  if MayeExtrudedRef<>nil then
   MayeExtruded:=MayeExtrudedRef.Value as TMayeSurface3D else
    MayeExtruded:=nil;
   if MayeExtruded=nil then
   MayeExtruded:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3DRef ) else
    MayeExtruded.Clear;

  // Extrude processing

 MayeExtruded.KeyName:=Context.EvalString(par5);
 MayeExtruded.fparent:=Drawer.Scene3D;
 ExtrudeSurfOnX(Obj3D as TMayeSurface3D,MayeExtruded as TMayeSurface3D,Context.EvalFloat(par2),Round(Context.EvalFloat(par3)),Context.EvalFloat(par4)<>0)
end;

{ TCommandExtrudeY }

constructor TCommandExtrudeY.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,parl:string;
    Obj3D,MayeExtruded:TObject3D;MayeExtrudedRef:TObject3DRef;
    pos:integer;

begin
 par1:=GetFirst(strContent,pos); //MayeSurface or blocname
 par2:=GetNext(strContent,pos);  // Abs Position or Translation
 par3:=GetNext(strContent,pos);  // nLong : number of maye for extrusion
 par4:=GetNext(strContent,pos);  // Type (0 - Translation,1-Absolute Position)
 par5:=GetNext(strContent,pos);  // KeyName of the extruded surface
 parl:=GetNext(strContent,pos);  // vide

 if parl<>'' then
  raise Exception.Create('Bad line parameter');
 Obj3D:=Drawer.Scene3DTree.GetObject3DRef(Context.EvalString(par1),true).Value;

 if par4='' then
  par4:='0';
 if par5='' then
  par5:='"_ExtrudedY'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';
 if Obj3D=nil then
   raise exception.create('TCommandExtrudeY.Create::This object3D does not exist in the scene.');
 if not(obj3D is TMayeSurface3D) then
  raise Exception.Create('TCommandExtrudeY.Create::This object3D must be a TMayeSurface3D.');

  MayeExtrudedRef:=(Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par5),true) as TObject3DRef);
  if MayeExtrudedRef<>nil then
   MayeExtruded:=MayeExtrudedRef.Value as TMayeSurface3D else
    MayeExtruded:=nil;
   if MayeExtruded=nil then
   MayeExtruded:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3DRef) else
    MayeExtruded.Clear;
  // Extrude processing

 MayeExtruded.KeyName:=Context.EvalString(par5);
 MayeExtruded.fParent:=Drawer.Scene3D;
 ExtrudeSurfOnY(Obj3D as TMayeSurface3D,MayeExtruded as TMayeSurface3D,Context.EvalFloat(par2),Round(Context.EvalFloat(par3)),Context.EvalFloat(par4)<>0)
end;

{ TCommandExtrudeZ }

constructor TCommandExtrudeZ.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,parl:string;
    Obj3D,MayeExtruded:TObject3D;MayeExtrudedRef:TObject3DRef;
    pos:integer;

begin
 par1:=GetFirst(strContent,pos); //MayeSurface or blocname
 par2:=GetNext(strContent,pos);  // Abs Position or Translation
 par3:=GetNext(strContent,pos);  // nLong : number of maye for extrusion
 par4:=GetNext(strContent,pos);  // Type (0 - Translation,1-Absolute Position)
 par5:=GetNext(strContent,pos);  // KeyName of the extruded surface
 parl:=GetNext(strContent,pos);  // vide

 if parl<>'' then
  raise Exception.Create('Bad line parameter');
 Obj3D:=Drawer.Scene3DTree.GetObject3DRef(Context.EvalString(par1),true).Value;

 if par4='' then
  par4:='0';
 if par5='' then
  par5:='"_ExtrudedZ'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';
 if Obj3D=nil then
   raise exception.create('TCommandExtrudeZ.Create::This object3D does not exist in the scene.');
 if not(obj3D is TMayeSurface3D) then
  raise Exception.Create('TCommandExtrudeZ.Create::This object3D must be a TMayeSurface3D.');


  MayeExtrudedRef:=(Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par5),true) as TObject3DRef);
  if MayeExtrudedRef<>nil then
   MayeExtruded:=MayeExtrudedRef.Value as TMayeSurface3D else
    MayeExtruded:=nil;
   if MayeExtruded=nil then
   MayeExtruded:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3DRef) else
    MayeExtruded.Clear;

  // Extrude processing

 MayeExtruded.KeyName:=Context.EvalString(par5);
 MayeExtruded.fParent:=Drawer.Scene3D;

 ExtrudeSurfOnZ(Obj3D as TMayeSurface3D,MayeExtruded as TMayeSurface3D,Context.EvalFloat(par2),Round(Context.EvalFloat(par3)),Context.EvalFloat(par4)<>0)
end;

{ TCommandExplode }

constructor TCommandExplode.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,parl:string;
    Scene3DRef:TTreeItemRef;Scene3D:TScene3D;
    pos,i:integer;
begin
 par1:=GetFirst(strContent,pos); //MayeSurface or blocname
 parl:=GetNext(strContent,pos);  // next

 if parl<>'' then
  raise Exception.Create('Bad line parameter');

 Scene3DRef:=Drawer.Scene3DTree.GetScene3DRef(Context.EvalString(par1),true);
 if Scene3DRef<>nil then
 begin
  Scene3D:=(Scene3DRef.Value as TScene3D);
  Scene3D.ChangeObjectParent(Drawer.Scene3D);// Change the object parent reference
  // Attention si la scène 3D contient aussi des sous-scènes
  for i:=0 to Scene3DRef.fChildNodes.Count -1 do
   Drawer.fTree3D.MoveScene3D(Scene3DRef,Drawer.Scene3DRef,((Scene3DRef.fchildnodes.items[i] as TTreeItemRef).Value as TScene3D));
  // remove the reference in the object parent list
  for i:=0 to Scene3DRef.fParentNode.fChildNodes.Count -1 do begin
   if (scene3DRef.fParentNode.fChildNodes.Items[i] as TTreeItemRef).Value=Scene3D then
   begin
    Scene3DRef.fparentNode.fChildNodes.Delete(i);
    break;
   end;
  end;
  // delete physically this object
  for i:=0 to Drawer.Scene3DList.Count -1 do begin
   if (Drawer.Scene3DList.Items[i]=Scene3D) then begin
    Drawer.Scene3DList.Delete(i);
    break;
   end;
  end;
 end else
  raise Exception.Create('TCommandExplode::Create:This object does not exist');
end;

{ TCommandRevolutionX }

constructor TCommandRevolutionX.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,parl:string;
    Obj3D,MayeRevolution:TObject3D;MayeRevolutionRef:TObject3DRef;
    pos:integer;

begin
 par1:=GetFirst(strContent,pos); //MayeSurface or blocname
 par2:=GetNext(strContent,pos);  // Phi0
 par3:=GetNext(strContent,pos);  // Phi1
 par4:=GetNext(strContent,pos);  // nLong : number of maye for extrusion
 par5:=GetNext(strContent,pos);  // KeyName of the extruded surface
 parl:=GetNext(strContent,pos);  // vide

 if parl<>'' then
  raise Exception.Create('Bad line parameter');
 Obj3D:=Drawer.Scene3DTree.GetObject3DRef(Context.EvalString(par1),true).Value;

 if par5='' then
  par5:='"_RevolutionX'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';
 if Obj3D=nil then
   raise exception.create('TCommandRevolutionX.Create::This object3D does not exist in the scene.');
 if not(obj3D is TMayeSurface3D) then
  raise Exception.Create('TCommandRevolutionX.Create::This object3D must be a TMayeSurface3D.');


  MayeRevolutionRef:=(Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par5),true) as TObject3DRef);
  if MayeRevolutionRef<>nil then
   MayeRevolution:=MayeRevolutionRef.Value as TMayeSurface3D else
    MayeRevolution:=nil;
   if MayeRevolution=nil then
   MayeRevolution:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3Dref) else
    MayeRevolution.Clear;

 MayeRevolution.KeyName:=Context.EvalString(par5);
 MayeRevolution.fParent:=Drawer.Scene3D;

// RevolutionSurfOnX(Obj3D as TMayeSurface3D,MayeRevolution as TMayeSurface3D,Context.EvalFloat(par2),Round(Context.EvalFloat(par3)),Context.EvalFloat(par4)<>0)

 RevolutionSurfOnX(obj3D as TMayeSurface3D,MayeRevolution as TMayeSurface3D,context.EvalFloat(par2),context.EvalFloat(par3),Round(Context.EvalFloat(par4)));
end;

{ TCommandRevolutionY }

constructor TCommandRevolutionY.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,parl:string;
    Obj3D,MayeRevolution:TObject3D;MayeRevolutionRef:TObject3DRef;
    pos:integer;

begin
 par1:=GetFirst(strContent,pos); //MayeSurface or blocname
 par2:=GetNext(strContent,pos);  // Phi0
 par3:=GetNext(strContent,pos);  // Phi1
 par4:=GetNext(strContent,pos);  // nLong : number of maye for extrusion
 par5:=GetNext(strContent,pos);  // KeyName of the extruded surface
 parl:=GetNext(strContent,pos);  // vide

 if parl<>'' then
  raise Exception.Create('Bad line parameter');
 Obj3D:=Drawer.Scene3DTree.GetObject3DRef(Context.EvalString(par1),true).Value;

 if par5='' then
  par5:='"_RevolutionX'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';
 if Obj3D=nil then
   raise exception.create('TCommandRevolutionX.Create::This object3D does not exist in the scene.');
 if not(obj3D is TMayeSurface3D) then
  raise Exception.Create('TCommandRevolutionX.Create::This object3D must be a TMayeSurface3D.');


  MayeRevolutionRef:=(Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par5),true) as TObject3DRef);
  if MayeRevolutionRef<>nil then
   MayeRevolution:=MayeRevolutionRef.Value as TMayeSurface3D else
    MayeRevolution:=nil;
   if MayeRevolution=nil then
   MayeRevolution:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3Dref) else
    MayeRevolution.Clear;

 MayeRevolution.KeyName:=Context.EvalString(par5);
 MayeRevolution.fParent:=Drawer.Scene3D;

// RevolutionSurfOnX(Obj3D as TMayeSurface3D,MayeRevolution as TMayeSurface3D,Context.EvalFloat(par2),Round(Context.EvalFloat(par3)),Context.EvalFloat(par4)<>0)

 RevolutionSurfOnY(obj3D as TMayeSurface3D,MayeRevolution as TMayeSurface3D,context.EvalFloat(par2),context.EvalFloat(par3),Round(Context.EvalFloat(par4)));
end;

{ TCommandRevolutionZ }

constructor TCommandRevolutionZ.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,parl:string;
    Obj3D,MayeRevolution:TObject3D;MayeRevolutionRef:TObject3DRef;
    pos:integer;

begin
 par1:=GetFirst(strContent,pos); //MayeSurface or blocname
 par2:=GetNext(strContent,pos);  // Phi0
 par3:=GetNext(strContent,pos);  // Phi1
 par4:=GetNext(strContent,pos);  // nLong : number of maye for extrusion
 par5:=GetNext(strContent,pos);  // KeyName of the extruded surface
 parl:=GetNext(strContent,pos);  // vide

 if parl<>'' then
  raise Exception.Create('Bad line parameter');
 Obj3D:=Drawer.Scene3DTree.GetObject3DRef(Context.EvalString(par1),true).Value;

 if par5='' then
  par5:='"_RevolutionX'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';
 if Obj3D=nil then
   raise exception.create('TCommandRevolutionX.Create::This object3D does not exist in the scene.');
 if not(obj3D is TMayeSurface3D) then
  raise Exception.Create('TCommandRevolutionX.Create::This object3D must be a TMayeSurface3D.');


  MayeRevolutionRef:=(Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par5),true) as TObject3DRef);
  if MayeRevolutionRef<>nil then
   MayeRevolution:=MayeRevolutionRef.Value as TMayeSurface3D else
    MayeRevolution:=nil;
   if MayeRevolution=nil then
   MayeRevolution:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3DRef) else
    MayeRevolution.Clear;

 MayeRevolution.KeyName:=Context.EvalString(par5);
 MayeRevolution.fParent:=Drawer.Scene3D;

// RevolutionSurfOnX(Obj3D as TMayeSurface3D,MayeRevolution as TMayeSurface3D,Context.EvalFloat(par2),Round(Context.EvalFloat(par3)),Context.EvalFloat(par4)<>0)

 RevolutionSurfOnZ(obj3D as TMayeSurface3D,MayeRevolution as TMayeSurface3D,context.EvalFloat(par2),context.EvalFloat(par3),Round(Context.EvalFloat(par4)));
end;

{ TCommandMayeLine }

// Ligne cachée en fonction de leur position par rapport aux autres mayetrifaces contrairement aux lignes standards.

constructor TCommandMayeLine.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,par6,par7,par8,par9,par10,parl:string;
    MayeLine:TMayeSurface3D; Object3DRef:TObject3DRef;
    x1,y1,z1,x2,y2,z2:extended;
    pos:integer;
begin
 par1:=GetFirst(strContent,pos); // x1
 par2:=GetNext(strContent,pos);  // y1
 par3:=GetNext(strContent,pos);  // z1
 par4:=GetNext(strContent,pos);  // x2
 par5:=GetNext(strContent,pos);  // y2
 par6:=GetNext(strContent,pos);  // z2
 par7:=GetNext(strContent,pos);  // nLong
 par8:=GetNext(strContent,pos);  // color
 par9:=GetNext(strContent,pos);  // Type
 par10:=GetNext(strContent,pos); // keyname
 parl:=GetNext(strContent,pos);  // empty

 if parl<>'' then
  raise Exception.Create('Bad line parameter');

  if par7='' then par7:='5';
 if par9='' then par9:='0';
 if par10='' then par10:='"_Line'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';

 Object3DRef:=Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par10),true) as TObject3DRef;
 if Object3DRef<>nil then
 MayeLine:=(Object3DRef.Value as TMayeSurface3D) else MayeLine:=nil;
  if MayeLine=nil then
   MayeLine:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3DRef) else
    MayeLine.Clear;

 x1:=fContext.Evalfloat(par1);
 y1:=fContext.Evalfloat(par2);
 z1:=fContext.Evalfloat(par3);

 x2:=fContext.EvalFloat(par4);
 y2:=fContext.Evalfloat(par5);
 z2:=fContext.Evalfloat(par6);

 with MayeLine do begin
   nLong:=round(Context.EvalFloat(par7));
   color:=round(Context.EvalFloat(par8));
   oType:=Drawer.GetTypeObject3D(Context.EvalString(par9));
   keyname:=Context.EvalString(par10);
//   fParent:=Drawer.Scene3D;
 end;

 CreateMayeLine(MayeLine,x1,y1,z1,x2,y2,z2);

end;

{ TCommandWall }

constructor TCommandWall.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);

var par1,par2,par3,par4,par5,par6,parl : string ;  pos:integer;
    length,height:extended;
    Object3DRef:TObject3DRef;MayeWall:TMayeSurface3D;
begin
 par1:=GetFirst(strContent,pos); // length
 par2:=GetNext(strContent,pos); //  height
 par3:=GetNext(strContent,pos);  // nlong
 par4:=GetNext(strContent,pos);  // nlat
 par5:=GetNext(strContent,pos);  // color
 par6:=GetNext(strContent,pos); // keyname
 parl:=GetNext(strContent,pos); // next

 if par3='' then par3:='5';
 if par4='' then par4:='5';
 if par5='' then par5:='0';

 if par6='' then par6:='"_Wall'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';

 length:=Context.Evalfloat(par1);
 height:=Context.evalFloat(par2);

 Object3DRef:=Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par6),true) as TObject3DRef;
 if Object3DRef<>nil then
 MayeWall:=(Object3DRef.Value as TMayeSurface3D) else MayeWall:=nil;
  if MayeWall=nil then
   MayeWall:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3DRef) else
    MayeWall.Clear;

 with MayeWall do begin
  nLong:=Round(Context.EvalFloat(par3));
  nLat:=Round(Context.EvalFloat(par4));
  Color:=Round(Context.EvalFloat(par5));
  Keyname:=Context.EValString(par6);
 end;

 CreateWall(MayeWall,length,height);

end;

{ TCommandWallCorner }

constructor TCommandWallCorner.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
  var par1,par2,par3,par4,parl:string;
      Object3DRef:TObject3DRef;MayeWall:TMayeSurface3D;
      pos:integer;
      height : extended;
begin

 par1:=GetFirst(strContent,pos); // height
 par2:=GetNext(strContent,pos);  // nlat
 par3:=GetNext(strContent,pos);  // color
 par4:=GetNext(strContent,pos); // keyname
 parl:=GetNext(strContent,pos); // next

 if par1='' then par1:='0';
 if par3='' then par3:='0';
 if par2='' then par2:='5';
 if par4='' then par4:='"_WallCorner'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';

 height:=Context.evalFloat(par1);

 Object3DRef:=Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par4),true) as TObject3DRef;
 if Object3DRef<>nil then
 MayeWall:=(Object3DRef.Value as TMayeSurface3D) else MayeWall:=nil;
  if MayeWall=nil then
   MayeWall:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3DRef) else
    MayeWall.Clear;

 with MayeWall do begin
  nLat:=Round(Context.EvalFloat(par2));
  Color:=Round(Context.EvalFloat(par3));
  Keyname:=Context.EValString(par4);
 end;

 CreateWallCorner(MayeWall,height);

end;

{ TCommandWallFence }

constructor TCommandWallFence.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,par6,parl : string ;  pos:integer;
    length,height:extended;
    Object3DRef:TObject3DRef;MayeWall:TMayeSurface3D;
begin
 par1:=GetFirst(strContent,pos); // length
 par2:=GetNext(strContent,pos); //  height
 par3:=GetNext(strContent,pos);  // nlong
 par4:=GetNext(strContent,pos);  // nlat
 par5:=GetNext(strContent,pos);  // color
 par6:=GetNext(strContent,pos); // keyname
 parl:=GetNext(strContent,pos); // next

 if par3='' then par3:='5';
 if par4='' then par4:='5';
 if par5='' then par5:='0';

 if par6='' then par6:='"_Wallfence'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';

 length:=Context.Evalfloat(par1);
 height:=Context.evalFloat(par2);

 Object3DRef:=Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par6),true) as TObject3DRef;
 if Object3DRef<>nil then
 MayeWall:=(Object3DRef.Value as TMayeSurface3D) else MayeWall:=nil;
  if MayeWall=nil then
   MayeWall:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3DRef) else
    MayeWall.Clear;

 with MayeWall do begin
  nLong:=Round(Context.EvalFloat(par3));
  nLat:=Round(Context.EvalFloat(par4));
  Color:=Round(Context.EvalFloat(par5));
  Keyname:=Context.EValString(par6);
 end;

 CreateWallFence(MayeWall,length,height);

end;

{ TCommandFence }

constructor TCommandFence.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var par1,par2,par3,par4,par5,par6,parl : string ;  pos:integer;
    length,height:extended;
    Object3DRef:TObject3DRef;MayeWall:TMayeSurface3D;

begin
 par1:=GetFirst(strContent,pos); // length
 par2:=GetNext(strContent,pos); //  height
 par3:=GetNext(strContent,pos);  // nlong
 par4:=GetNext(strContent,pos);  // nlat
 par5:=GetNext(strContent,pos);  // color
 par6:=GetNext(strContent,pos); // keyname
 parl:=GetNext(strContent,pos); // next

 if par3='' then par3:='5';
 if par4='' then par4:='5';
 if par5='' then par5:='0';

 if par6='' then par6:='"_Fence'+inttostr(Drawer.MayeSurface3DList.Count+1)+'"';

 length:=Context.Evalfloat(par1);
 height:=Context.evalFloat(par2);

 Object3DRef:=Drawer.Scene3DTree.GetMayeSurface3DRef(Context.EvalString(par6),true) as TObject3DRef;
 if Object3DRef<>nil then
 MayeWall:=(Object3DRef.Value as TMayeSurface3D) else MayeWall:=nil;
  if MayeWall=nil then
   MayeWall:=Drawer.Scene3DTree.AddMayeSurface3D(Drawer.CurrentScene3DRef) else
    MayeWall.Clear;

 with MayeWall do begin
  nLong:=Round(Context.EvalFloat(par3));
  nLat:=Round(Context.EvalFloat(par4));
  Color:=Round(Context.EvalFloat(par5));
  Keyname:=Context.EValString(par6);
 end;

 CreateFence(MayeWall,length,height);

end;

{ TCommandUnHide }

constructor TCommandUnHide.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var
 par1,parl,sKeyname : string;
 Scene3DRef : TTreeItemRef;
 Object3DRef : TObject3DRef;
 Object3D : TObject3D;
 Scene3D : TScene3D;
 pos : integer;

begin
 par1:=GetFirst(strContent,pos); // keyname
 parl:=GetNext(strContent,pos);  // vide

 if parl<>'' then
  raise Exception.Create('Bad line parameter');
 sKeyname:=Context.EvalString(par1);
 Scene3DRef:=Drawer.Scene3DTree.GetScene3DRef(sKeyname,true);
 if Scene3DRef=nil then begin
   Object3DRef:=Drawer.Scene3DTree.GetObject3DRef(sKeyname,true);
   if Object3DRef<>nil then
   Object3D:=Object3DRef.value else Object3D:=nil;
   if Object3D=nil then
    raise exception.create('TCommandRotate.Create::This object3D does not exist in the scene');

   if (Object3D is TMayeSurface3D) then
    (Object3D as TMayeSurface3D).SetUnHide else
     Object3D.Hide:=false;
  end else
  begin
   Scene3D:=Scene3DRef.Value as TScene3D;
   if Scene3D=nil then
       raise exception.create('TCommandRotate.Create::This object3D does not exist in the scene');
   Scene3D.SetUnHide;
  end;


end;

{ TCommandHide }

constructor TCommandHide.create(strContent: string;
  context: TCustomContext; Drawer: TDrawer3D; output: TStringList);
var
 par1,parl,sKeyname : string;
 Scene3DRef : TTreeItemRef;
 Object3DRef : TObject3DRef;
 Object3D : TObject3D;
 Scene3D : TScene3D;
 pos : integer;
begin
 par1:=GetFirst(strContent,pos); // keyname
 parl:=GetNext(strContent,pos);  // vide

 if parl<>'' then
  raise Exception.Create('Bad line parameter');
 sKeyname:=Context.EvalString(par1);
 Scene3DRef:=Drawer.Scene3DTree.GetScene3DRef(sKeyname,true);
 if Scene3DRef=nil then begin
   Object3DRef:=Drawer.Scene3DTree.GetObject3DRef(sKeyname,true);
   if Object3DRef<>nil then
   Object3D:=Object3DRef.value else Object3D:=nil;
   if Object3D=nil then
    raise exception.create('TCommandRotate.Create::This object3D does not exist in the scene');

   if (Object3D is TMayeSurface3D) then
    (Object3D as TMayeSurface3D).SetHide else
     Object3D.Hide:=true;
  end else
  begin
   Scene3D:=Scene3DRef.Value as TScene3D;
   if Scene3D=nil then
       raise exception.create('TCommandRotate.Create::This object3D does not exist in the scene');
   Scene3D.SetHide;
  end;

end;

end.



