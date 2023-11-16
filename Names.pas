unit Names;

(*
  Nametype 1 edition
  3 pressrun
  4 publication
  5 section
  7 location
  8 proofs  / ogs� hardproof
  11 device
  12 flatproof
  13 custommer
  14 Ripsetup
  98 Events
  99 FileServers
  100 color
  110 pressname
  120 pageformat
  130 prod_pagetable ??
  140

*)
interface

uses
  Vcl.Dialogs, Data.DB, System.SysUtils, System.Classes, Data.SqlExpr,
  System.UITypes,UUtils;

// Const
// namedataSize = 1000;

type

  TFileServerType = Array of record // NAN 201601212
    Servertype: Integer;
    Name: string;
    Share: string;
    Username: string;
    Password: string;
    IP: string;
    FullPath: string;
    AlternativeIP: string;
  end;

  Tnamedatatype = Array of record ID: Integer;
  Name: String;
end;

tNames = class(TComponent)public FileServerNames: TFileServerType;
// NAN 201601212
NFileServerNames:
Integer; // NAN 201601212

PNpressnames:
Integer;
PDFCOLORID:
Integer;
private
  Customertableok: Integer; // -1 notinit, 0 no table 1 table ok
  RIPsetuptableok: Integer; // -1 notinit, 0 no table 1 table ok
  PNcolornames: Integer;
  Pcolornames: Tnamedatatype;
  Ppressnames: Tnamedatatype;
  PNeditions: Integer;
  Peditions: Tnamedatatype;
  // PNpressruns : Integer;
  // Ppressruns : Tnamedatatype;
  // PNproductionruns : Integer;
  // Pproductionruns : Tnamedatatype;
  PNpageformats: Integer;
  Ppageformats: Tnamedatatype;
  PNproofs: Integer;
  Pproofs: Tnamedatatype;
  PNlocations: Integer;
  Plocations: Tnamedatatype;
  PNpagetemplates: Integer;
  Ppagetemplates: Tnamedatatype;
  PNissues: Integer;
  Pissues: Tnamedatatype;
  PNsections: Integer;
  Psections: Tnamedatatype;
  PNPublications: Integer;
  PPublications: Tnamedatatype;

  PNdevices: Integer;
  Pdevices: Tnamedatatype;
  PNFlatProofConfigurations: Integer;
  PFlatProofConfigurations: Tnamedatatype;

  PNCustomers: Integer;
  PCustomers: Tnamedatatype;

  // PRipSetupsInDB : Boolean;
  PNripsetups: Longint;
  PRipSetups: Tnamedatatype;

  PNEvents: Integer;
  PEvents: Tnamedatatype;

  PGetnames: TSQLQuery;

  DeviceInkAlias: Tstringlist; // dev,press,alias
  PRipSetupNameList: Tstringlist;
  Peditionlist: Tstringlist;
  PColornamelist: Tstringlist;
  PPressnamelist: Tstringlist;
  Ppressrunlist: Tstringlist;
  Pproductionrunlist: Tstringlist;
  Ppageformatlist: Tstringlist;
  Pprooflist: Tstringlist;
  Plocationlist: Tstringlist;
  Ppagetemplatelist: Tstringlist;
  Pissuelist: Tstringlist;
  Psectionlist: Tstringlist;
  Pdevicelist: Tstringlist;

  Ppublicationlist: Tstringlist;
  PFlatProofConfigurationlist: Tstringlist;
  PCustomerlist: Tstringlist;
  PEventList: Tstringlist;

  Function Getpublicationnames: Tstringlist;
  procedure setpublicationnames(const Astrings: Tstringlist);
  Function GetFlatProofConfigurationnames: Tstringlist;
  procedure setFlatProofConfigurationnames(const Astrings: Tstringlist);
  Function GetCustomernames: Tstringlist;
  procedure setCustomernames(const Astrings: Tstringlist);

  (*
    Function Getdevicenames : TStringList;
    procedure setdevicenames (const Astrings : TStringList);
  *)

  Function Geteditionnames: Tstringlist;
  procedure seteditionnames(const Astrings: Tstringlist);

  Function GetColornames: Tstringlist;
  procedure setColornames(const Astrings: Tstringlist);

  Function Getpressnames: Tstringlist;
  procedure setpressnames(const Astrings: Tstringlist);

  (* Function Getpressrunnames : TStringList;
    procedure setpressrunnames (const Astrings : TStringList);

    Function Getproductionrunnames : TStringList;
    procedure setproductionrunnames (const Astrings : TStringList);
  *)

  Function Getpageformatnames: Tstringlist;
  procedure setpageformatnames(const Astrings: Tstringlist);
  Function Getproofnames: Tstringlist;
  procedure setproofnames(const Astrings: Tstringlist);
  Function Getlocationnames: Tstringlist;
  procedure setlocationnames(const Astrings: Tstringlist);
  Function Getpagetemplatenames: Tstringlist;
  procedure setpagetemplatenames(const Astrings: Tstringlist);
  Function Getissuenames: Tstringlist;
  procedure setissuenames(const Astrings: Tstringlist);
  Function Getsectionnames: Tstringlist;
  procedure setsectionnames(const Astrings: Tstringlist);

  Function Getripsetupnames: Tstringlist;
  procedure setripsetupnames(const Astrings: Tstringlist);

  Function GetEventNames: Tstringlist;
  procedure SetEventNames(const Astrings: Tstringlist);


protected
  { Protected declarations }
public
  constructor Create(AOwner: TComponent);
  override;
published

  Function loadalist(listnumber: Integer): Boolean;
  Procedure initializedb(Var ASQLQueryname: TSQLQuery);

  property Editionnames: Tstringlist read Geteditionnames Write seteditionnames;
  Function editionIDtoname(ID: Integer): String;
  Function editionnametoid(name: string): Integer;

  property Colornames: Tstringlist read GetColornames Write setColornames;
  Function ColornameIDtoname(ID: Integer): String;
  Function Colornametoid(name: string): Integer;

  property pressnames: Tstringlist read Getpressnames Write setpressnames;
  Function pressnameIDtoname(ID: Integer): String;
  Function pressnametoid(name: string): Integer;

  // property pressrunnames : TStringList read Getpressrunnames Write setpressrunnames;
  // Function pressrunIDtoname(ID : Integer):String;
  // Function pressrunnametoid(name : string):integer;

  // property productionrunnames : TStringList read Getproductionrunnames Write setproductionrunnames;
  Function productionrunIDtoname(ID: Integer): String;
  Function productionrunnametoid(name: string): Integer;

  property pageformatnames: Tstringlist read Getpageformatnames
    Write setpageformatnames;
  Function pageformatIDtoname(ID: Integer): String;
  Function pageformatnametoid(name: string): Integer;
  property proofnames: Tstringlist read Getproofnames Write setproofnames;
  Function proofIDtoname(ID: Integer): String;
  Function proofnametoid(name: string): Integer;
  property locationnames: Tstringlist read Getlocationnames
    Write setlocationnames;
  Function locationIDtoname(ID: Integer): String;
  Function locationnametoid(name: string): Integer;
  property pagetemplatenames: Tstringlist read Getpagetemplatenames
    Write setpagetemplatenames;
  Function pagetemplateIDtoname(ID: Integer): String;
  Function pagetemplatenametoid(name: string): Integer;

  property issuenames: Tstringlist read Getissuenames Write setissuenames;

  property sectionnames: Tstringlist read Getsectionnames Write setsectionnames;

  property RipSetupnames: Tstringlist read Getripsetupnames
    Write setripsetupnames;
  Function ripsetupIDtoname(ID: Integer): String;
  Function ripsetupnametoid(name: string): Integer;

  Function issueIDtoname(ID: Integer): String;

  Function sectionIDtoname(ID: Integer): String;

  Function issuenametoid(name: string): Integer;
  Function sectionnametoid(name: string): Integer;

  property publicationnames: Tstringlist read Getpublicationnames
    Write setpublicationnames;
  Function publicationIDtoname(ID: Integer): String;
  Function PublicationIDtoNameReload(ID: Integer): String;
  Function publicationnametoid(name: string): Integer;

  property devicenames: Tstringlist read Getpublicationnames
    Write setpublicationnames;
  Function deviceIDtoname(ID: Integer): String;
  Function devicenametoid(name: string): Integer;

  property FlatProofConfigurationnames: Tstringlist
    read GetFlatProofConfigurationnames Write setFlatProofConfigurationnames;
  Function FlatProofConfigurationIDtoname(ID: Integer): String;
  Function FlatProofConfigurationnametoid(name: string): Integer;

  property Customernames: Tstringlist read GetCustomernames
    Write setCustomernames;
  Function CustomerIDtoname(ID: Integer): String;
  Function Customernametoid(name: string): Integer;

  // Function ISANewname(Nametype : Integer;
  // NewName : String):boolean;
  Function Addname(Nametype: Integer; NewName: String): Boolean;
  Function Loadnames: Boolean;
  Function LoadnamesSmall: Boolean;

  Function GetorderOftype(Nametype: Longint; NameID: Longint): Longint;

  function GetFirstPressName: string;
  function GetFirstPressID: Integer;

  function GetMainFileServer: string;
  function GetMainFileServerShare: string;

  function GetPlanCenterFileServer: string;
  function GetPlanCenterFileServerShare: string;

  property Eventnames: Tstringlist read GetEventNames Write SetEventNames;

  function eventnumberfromname(name: string): Integer;
  function eventnamefromnumber(ID: Integer): string;

  function GetPublicationAlias(name: string) : string;

  // procedure LoadUsers;
  end;

  procedure Register;

implementation

uses UMain, UPrefs;

constructor tNames.Create(AOwner: TComponent);
Begin
  inherited Create(AOwner);
  // PGetnames  := TSQLQuery.create(self);
  DeviceInkAlias := Tstringlist.Create;
  Peditionlist := Tstringlist.Create;
  PColornamelist := Tstringlist.Create;
  PPressnamelist := Tstringlist.Create;
  Ppressrunlist := Tstringlist.Create;
  Pproductionrunlist := Tstringlist.Create;
  Ppageformatlist := Tstringlist.Create;
  Pprooflist := Tstringlist.Create;
  Plocationlist := Tstringlist.Create;
  Ppagetemplatelist := Tstringlist.Create;
  Psectionlist := Tstringlist.Create;
  Ppublicationlist := Tstringlist.Create;
  Pdevicelist := Tstringlist.Create;
  PFlatProofConfigurationlist := Tstringlist.Create;
  PCustomerlist := Tstringlist.Create;

  PRipSetupNameList := Tstringlist.Create;
  Pissuelist := Tstringlist.Create;
  PEventList := Tstringlist.Create;

  NFileServerNames := 0; // NAN 20161212

  Customertableok := -1;
  RIPsetuptableok := -1;
  PDFCOLORID := 5;
end;

Function tNames.loadalist(listnumber: Integer): Boolean;
Begin
  result := false;
  // IF not PRipSetupsInDB then
  // begin
  // end;
  try
    Case listnumber of
      1:
        Begin // edition
          // Setlength(Peditions, 1);
          PGetnames.Sql.Clear;
          PGetnames.Sql.Add
            ('SELECT EditionID,[Name] FROM EditionNames (NOLOCK) ORDER BY [Name] ');
          PGetnames.open;
          PNeditions := 0;
          Peditionlist.Clear;
          While not PGetnames.eof do
          begin
            Inc(PNeditions);
            SetLength(Peditions, PNeditions + 1);
            Peditions[PNeditions].ID := PGetnames.Fields[0].AsInteger;
            Peditions[PNeditions].Name := PGetnames.Fields[1].AsString;
            Peditionlist.Add(Peditions[PNeditions].Name);
            PGetnames.Next;
          end;
          PGetnames.Close;
        End;

      2:
        Begin // issue      //Issue table
          // Setlength(Pissues,1);
          PGetnames.Sql.Clear;
          PGetnames.Sql.Add
            ('SELECT IssueID,[Name] FROM IssueNames (NOLOCK) ORDER BY [Name] ');
          PGetnames.open;
          PNissues := 0;
          Pissuelist.Clear;
          While not PGetnames.eof do
          begin
            Inc(PNissues);
            SetLength(Pissues, PNissues + 1);
            Pissues[PNissues].ID := PGetnames.Fields[0].AsInteger;
            Pissues[PNissues].Name := PGetnames.Fields[1].AsString;
            Pissuelist.Add(Pissues[PNissues].Name);
            break;
            PGetnames.Next;
          end;
          PGetnames.Close;

        end;
      3:
        Begin // pressrun
          // Setlength(Ppressruns,0);
          (* PGetnames.Sql.Clear;
            PGetnames.Sql.Add('SELECT PressRunID,[Name] FROM PressRunNames (NOLOCK) ORDER BY [Name] ');
            PGetnames.Open;
            PNpressruns := 0;
            Ppressrunlist.Clear;
            While not PGetnames.Eof do
            begin
            Inc(PNpressruns);
            SetLength(Ppressruns, PNpressruns+1);
            Ppressruns[PNpressruns].ID := PGetnames.Fields[0].AsInteger;
            Ppressruns[PNpressruns].name := PGetnames.Fields[1].AsString;

            Ppressrunlist.Add(Ppressruns[PNpressruns].name);
            PGetnames.Next;
            end;
            PGetnames.Close; *)

        End;
      4:
        Begin // publication
          PGetnames.Sql.Clear;
          PGetnames.Sql.Add
            ('SELECT PublicationID,[Name] FROM PublicationNames (NOLOCK) ORDER BY [Name] ');
          PGetnames.open;
          PNPublications := 0;
          Ppublicationlist.Clear;

          While not PGetnames.eof do
          begin
            Inc(PNPublications);
            SetLength(PPublications, PNPublications + 1);

            PPublications[PNPublications].ID := PGetnames.Fields[0].AsInteger;
            PPublications[PNPublications].Name := PGetnames.Fields[1].AsString;
            Ppublicationlist.Add(PPublications[PNPublications].Name);
            PGetnames.Next;
          end;
          PGetnames.Close;

        End;
      5:
        Begin // section
          Psectionlist.Clear;
          PGetnames.Sql.Clear;
          PGetnames.Sql.Add
            ('SELECT SectionID,[Name] FROM SectionNames (NOLOCK) ORDER BY [Name]');
          PGetnames.open;
          PNsections := 0;
          While not PGetnames.eof do
          begin
            Inc(PNsections);
            SetLength(Psections, PNsections + 1);
            Psections[PNsections].ID := PGetnames.Fields[0].AsInteger;
            Psections[PNsections].Name := PGetnames.Fields[1].AsString;
            Psectionlist.Add(Psections[PNsections].Name);
            PGetnames.Next;
          end;
          PGetnames.Close;

        End;
      6:
        Begin // pagetemplate
        End;
      7:
        Begin // location
          PGetnames.Sql.Clear;
          PGetnames.Sql.Add
            ('SELECT LocationID,[Name] FROM LocationNames (NOLOCK) ORDER BY [Name]');

          PGetnames.open;
          PNlocations := 0;
          Plocationlist.Clear;
          While not PGetnames.eof do
          begin
            Inc(PNlocations);
            SetLength(Plocations, PNlocations + 1);
            Plocations[PNlocations].ID := PGetnames.Fields[0].AsInteger;
            Plocations[PNlocations].Name := PGetnames.Fields[1].AsString;
            Plocationlist.Add(Plocations[PNlocations].Name);
            PGetnames.Next;
          end;
          PGetnames.Close;

        End;
      8:
        Begin // proof
          PGetnames.Sql.Clear;
          PGetnames.Sql.Add
            ('SELECT ProofID, ProofName FROM ProofConfigurations (NOLOCK) ORDER BY ProofName ');
          PGetnames.open;
          PNproofs := 0;
          Pprooflist.Clear;
          While not PGetnames.eof do
          begin
            Inc(PNproofs);
            SetLength(Pproofs, PNproofs + 1);
            Pproofs[PNproofs].ID := PGetnames.Fields[0].AsInteger;
            Pproofs[PNproofs].Name := PGetnames.Fields[1].AsString;
            Pprooflist.Add(Pproofs[PNproofs].Name);
            PGetnames.Next;
          end;
          PGetnames.Close;

        End;

      9:
        Begin // productionrun

          (* PGetnames.Sql.Clear;
            PGetnames.Sql.Add('SELECT ProductionID,[Name] FROM ProductionNames (NOLOCK) ORDER BY [Name] ');
            PGetnames.Open;
            PNproductionruns := 0;
            Pproductionrunlist.Clear;
            While not PGetnames.Eof do
            begin
            Inc(PNproductionruns);
            SetLength(Pproductionruns, PNproductionruns+1);
            Pproductionruns[PNproductionruns].ID := PGetnames.Fields[0].AsInteger;
            Pproductionruns[PNproductionruns].Name := PGetnames.Fields[1].AsString;

            Pproductionrunlist.Add(Pproductionruns[PNproductionruns].name);
            PGetnames.Next;
            end;
            PGetnames.Close;
          *)
        End;
      11:
        Begin // device
          PGetnames.Sql.Clear;
          PGetnames.Sql.Add
            ('SELECT DeviceID,DeviceName FROM DeviceConfigurations (NOLOCK) ORDER BY DeviceName ');
          PGetnames.open;
          PNdevices := 0;
          Pdevicelist.Clear;
          While not PGetnames.eof do
          begin
            Inc(PNdevices);
            SetLength(Pdevices, PNdevices + 1);

            Pdevices[PNdevices].ID := PGetnames.Fields[0].AsInteger;
            Pdevices[PNdevices].Name := PGetnames.Fields[1].AsString;

            Pdevicelist.Add(Pdevices[PNdevices].Name);

            // Moved from FormMain.LoadIDs
            // now not used..
            // devicenames[Pdevices[PNdevices].ID] := Pdevices[PNdevices].name;

            PGetnames.Next;
          end;
          PGetnames.Close;
        End;
      12:
        Begin // FlatProofConfiguration
          PGetnames.Sql.Clear;
          PGetnames.Sql.Add
            ('SELECT ProofID,ProofName FROM FlatProofConfigurations (NOLOCK) ORDER BY ProofName ');
          PGetnames.open;
          PNFlatProofConfigurations := 0;
          PFlatProofConfigurationlist.Clear;

          While not PGetnames.eof do
          begin
            Inc(PNFlatProofConfigurations);
            SetLength(PFlatProofConfigurations, PNFlatProofConfigurations + 1);
            PFlatProofConfigurations[PNFlatProofConfigurations].ID :=
              PGetnames.Fields[0].AsInteger;
            PFlatProofConfigurations[PNFlatProofConfigurations].Name :=
              PGetnames.Fields[1].AsString;
            PFlatProofConfigurationlist.Add
              (PFlatProofConfigurations[PNFlatProofConfigurations].Name);
            PGetnames.Next;
          end;
          PGetnames.Close;
        End;
      13:
        Begin // Customer
          PNCustomers := 0;
          SetLength(PCustomers, 0);

          PNCustomers := 0;
          PCustomerlist.Clear;

          if Customertableok = -1 then
          begin
            PGetnames.Sql.Clear;
            PGetnames.Sql.Add('SELECT * FROM dbo.sysobjects');
            PGetnames.Sql.Add('WHERE name = ' + '''' + 'Customernames' + '''');
            PGetnames.open;
            if PGetnames.eof then
              Customertableok := 0
            else
              Customertableok := 1;
            PGetnames.Close;
          End;

          if Customertableok = 1 then
          begin

            PGetnames.Sql.Clear;
            PGetnames.Sql.Add
              ('SELECT CustomerID,CustomerName from Customernames (NOLOCK) ORDER BY CustomerName');
            PGetnames.open;
            While not PGetnames.eof do
            begin
              Inc(PNCustomers);
              SetLength(PCustomers, PNCustomers + 1);
              PCustomers[PNCustomers].ID := PGetnames.Fields[0].AsInteger;
              PCustomers[PNCustomers].Name := PGetnames.Fields[1].AsString;
              PCustomerlist.Add(PCustomers[PNCustomers].Name);
              PGetnames.Next;
            end;
            PGetnames.Close;
          End;

        End;
      14:
        Begin
          SetLength(PRipSetups, 0);
          PNripsetups := 0;
          PRipSetupNameList.Clear;
          if RIPsetuptableok = -1 then
          begin
            PGetnames.Sql.Clear;
            PGetnames.Sql.Add('SELECT * FROM dbo.sysobjects');
            PGetnames.Sql.Add('WHERE Name = ' + '''' + 'RipSetupNames' + '''');
            PGetnames.open;
            if PGetnames.eof then
              RIPsetuptableok := 0
            else
              RIPsetuptableok := 1;
            PGetnames.Close;
          End;

          IF RIPsetuptableok = 1 then
          begin
            PGetnames.Sql.Clear;
            PGetnames.Sql.Add
              ('SELECT RipSetupID,[Name] FROM RipSetupNames (NOLOCK) ORDER BY [Name]');
            PGetnames.open;
            While not PGetnames.eof do
            begin
              Inc(PNripsetups);
              SetLength(PRipSetups, PNripsetups + 1);
              PRipSetups[PNripsetups].ID := PGetnames.Fields[0].AsInteger;
              PRipSetups[PNripsetups].Name := PGetnames.Fields[1].AsString;
              PRipSetupNameList.Add(PRipSetups[PNripsetups].Name);
              PGetnames.Next;
            end;
            PGetnames.Close;
          end;
        end;

      100:
        begin // color
          PGetnames.Sql.Clear;
          PGetnames.Sql.Add
            ('SELECT ColorID,ColorName,ColorOrder FROM ColorNames (NOLOCK) ORDER BY ColorOrder');
          PGetnames.open;
          PNcolornames := 0;
          PColornamelist.Clear;
          While not PGetnames.eof do
          begin
            Inc(PNcolornames);
            SetLength(Pcolornames, PNcolornames + 1);
            Pcolornames[PNcolornames].ID := PGetnames.Fields[0].AsInteger;
            Pcolornames[PNcolornames].Name := PGetnames.Fields[1].AsString;
            PColornamelist.Add(Pcolornames[PNcolornames].Name);
            if (Pcolornames[PNcolornames].Name = 'PDF') then
              PDFCOLORID := Pcolornames[PNcolornames].ID;

            PGetnames.Next;
          end;
          PGetnames.Close;
        end;

      110:
        begin // pressnames
          PGetnames.Sql.Clear;
          PGetnames.Sql.Add
            ('SELECT PressID,PressName FROM PressNames (NOLOCK) ORDER BY PressName');
          PGetnames.open;
          PNpressnames := 0;
          PPressnamelist.Clear;
          While not PGetnames.eof do
          begin
            Inc(PNpressnames);
            SetLength(Ppressnames, PNpressnames + 1);
            Ppressnames[PNpressnames].ID := PGetnames.Fields[0].AsInteger;
            Ppressnames[PNpressnames].Name := PGetnames.Fields[1].AsString;
            PPressnamelist.Add(Ppressnames[PNpressnames].Name);
            PGetnames.Next;
          end;
          PGetnames.Close;
        end;

      120:
        begin
          PGetnames.Sql.Clear;
          PGetnames.Sql.Add('SELECT PageFormatID,PageFormatName FROM pageformatnames (NOLOCK) ORDER BY PageFormatName');
          PGetnames.open;
          PNpageformats := 0;
          Ppageformatlist.Clear;
          While not PGetnames.eof do
          begin
            Inc(PNpageformats);
            SetLength(Ppageformats, PNpageformats + 1);
            Ppageformats[PNpageformats].ID := PGetnames.Fields[0].AsInteger;
            Ppageformats[PNpageformats].Name := PGetnames.Fields[1].AsString;
            Ppageformatlist.Add(Ppageformats[PNpageformats].Name);
            PGetnames.Next;
          end;
          PGetnames.Close;
        End;

      130:
        begin
        end;

      98:
        begin
          // NAN 20161212
          // NOTE:  PEvents starts at index 1 (as the rest of tNames elements)

          PGetnames.Sql.Clear;
          PGetnames.Sql.Add('SELECT EventNumber,EventName FROM EventCodes (NOLOCK) ORDER BY EventNumber');
          PGetnames.open;
          PNEvents := 0;
          PEventList.Clear;
          while not PGetnames.eof do
          begin
            Inc(PNEvents);
            SetLength(PEvents, PNEvents + 1);
            PEvents[PNEvents].ID := PGetnames.Fields[0].AsInteger;
            PEvents[PNEvents].Name := PGetnames.Fields[1].AsString;
            PGetnames.Next;
            PEventList.Add(PEvents[PNEvents].Name);
          end;
          PGetnames.Close;
        end;
      99:
        begin

          // NAN 20161212
          // NOTE:  FileServerNames starts at index 1 (as the rest of tNames elements)

          // PGetnames.sql.Clear;
          // PGetnames.sql.add('SELECT COUNT(*) FROM FileServers WITH (NOLOCK)');
          // PGetnames.open;
          // Setlength(FileServerNames,PGetnames.Fields[0].AsInteger+1(* * SizeOf(TFileServerType)*));
          // PGetnames.Close;

          PGetnames.Sql.Clear;
          PGetnames.Sql.Add('SELECT Name,Servertype,CCDataShare,UserName,Password,IP FROM FileServers WITH (NOLOCK) ORDER BY ServerType');
          PGetnames.Open;
          NFileServerNames := 0;
          while not PGetnames.eof do
          begin
            Inc(NFileServerNames);
            SetLength(FileServerNames, NFileServerNames + 1);
            FileServerNames[NFileServerNames].Name :=
              Trim(PGetnames.Fields[0].AsString);
            FileServerNames[NFileServerNames].Servertype := PGetnames.Fields[1]
              .AsInteger;
            FileServerNames[NFileServerNames].Share :=
              Trim(PGetnames.Fields[2].AsString);
            FileServerNames[NFileServerNames].Username :=
              Trim(PGetnames.Fields[3].AsString);
            FileServerNames[NFileServerNames].Password :=
              TUtils.DecodeBlowfish(Trim(PGetnames.Fields[4].AsString));
            FileServerNames[NFileServerNames].IP :=
              Trim(PGetnames.Fields[5].AsString);

            if (FileServerNames[NFileServerNames].IP <> '') then
              FileServerNames[NFileServerNames].FullPath :=
                '\\' + IncludeTrailingBackSlash
                (FileServerNames[NFileServerNames].IP) + FileServerNames
                [NFileServerNames].Share + '\'
            else
              FileServerNames[NFileServerNames].FullPath :=
                '\\' + IncludeTrailingBackSlash
                (FileServerNames[NFileServerNames].Name) + FileServerNames
                [NFileServerNames].Share + '\';
            FileServerNames[NFileServerNames].AlternativeIP := '';
            // Will be set in ActivateData when ini-file is read..
            PGetnames.Next;
          end;
          PGetnames.Close;

        end;
    end;

    result := true;
  Except
  end;
end;

Function tNames.LoadnamesSmall: Boolean;
begin
  result := false;
  Try

    loadalist(1); // editionnames

    loadalist(4); // publicationnames

    loadalist(5); // section
    result := true;
  Except
    result := false;
  end;
end;

Function tNames.Loadnames: Boolean;
Begin
  result := false;
  Try

    loadalist(1); // editionnames

    loadalist(2); // issuenames

    // loadalist(3); //pressrunnames

    loadalist(4); // publicationnames

    loadalist(5); // section

    loadalist(7); // locationnames

    loadalist(8); // proofnames

    // loadalist(9); //production

    loadalist(11); // devicenames

    loadalist(12); // FlatProofConfigurationnames

    loadalist(13); // Customernames

    loadalist(14); // Ripsetupnames;
    loadalist(100); // color

    loadalist(110); // pressnames

    loadalist(120); // pageformatnames

    // loadalist(130); //prod_pagetemplatenames

    loadalist(99); // FileServers

    loadalist(98); // Events

    result := true;
  Except
    result := false;
  end;
end;

procedure Register;
begin
  RegisterComponents('INFRA', [tNames]);
end;

Function tNames.ColornameIDtoname(ID: Integer): String;
Var
  I: Integer;
Begin
  result := '';
  For I := 1 to PNcolornames do
  begin
    IF Pcolornames[I].ID = ID then
    begin
      result := Pcolornames[I].Name;
      break;
    end;
  end;
End;

Function tNames.Colornametoid(Name: string): Integer;
Var
  I: Integer;
Begin
  result := -1;
  For I := 1 to PNcolornames do
  begin
    IF Pcolornames[I].Name = name then
    begin
      result := Pcolornames[I].ID;
      break;
    end;
  end;
End;

Function tNames.pressnameIDtoname(ID: Integer): String;
Var
  I: Integer;
Begin
  result := '';
  For I := 1 to PNpressnames do
  begin
    IF Ppressnames[I].ID = ID then
    begin
      result := Ppressnames[I].Name;
      break;
    end;
  end;
End;

function tNames.GetFirstPressID: Integer;
begin
  result := Ppressnames[1].ID;
end;

function tNames.GetFirstPressName: string;
begin
  result := Ppressnames[1].Name;
end;

Function tNames.pressnametoid(Name: string): Integer;
Var
  I: Integer;
Begin
  result := -1;
  For I := 1 to PNpressnames do
  begin
    IF Ppressnames[I].Name = name then
    begin
      result := Ppressnames[I].ID;
      break;
    end;
  end;
End;

Function tNames.editionIDtoname(ID: Integer): String;
Var
  I: Integer;
Begin
  result := '';
  For I := 1 to PNeditions do
  begin
    IF Peditions[I].ID = ID then
    begin
      result := Peditions[I].Name;
      break;
    end;
  end;
End;

Function tNames.editionnametoid(Name: string): Integer;
Var
  I: Integer;
Begin
  result := -1;
  name := uppercase(name);
  For I := 1 to PNeditions do
  begin
    IF uppercase(Peditions[I].Name) = name then
    begin
      result := Peditions[I].ID;
      break;
    end;
  end;
End;

Function tNames.ripsetupIDtoname(ID: Integer): String;
Var
  I: Integer;
Begin
  result := '';
  For I := 1 to PNripsetups do
  begin
    IF PRipSetups[I].ID = ID then
    begin
      result := PRipSetups[I].Name;
      break;
    end;
  end;
End;

Function tNames.ripsetupnametoid(Name: string): Integer;
Var
  I: Integer;
Begin
  result := -1;
  For I := 1 to PNripsetups do
  begin
    IF PRipSetups[I].Name = name then
    begin
      result := PRipSetups[I].ID;
      break;
    end;
  end;
End;

Function tNames.GetColornames: Tstringlist;
Begin
  result := PColornamelist;
End;

Function tNames.Getpressnames: Tstringlist;
Begin
  result := PPressnamelist;
End;

Function tNames.Geteditionnames: Tstringlist;
Begin
  result := Peditionlist;
End;

procedure tNames.seteditionnames(const Astrings: Tstringlist);
Begin
  // Peditionlist := Astrings;
End;

Function tNames.Getripsetupnames: Tstringlist;
Begin
  result := PRipSetupNameList;
End;

procedure tNames.setripsetupnames(const Astrings: Tstringlist);
Begin
  // Pripsetuplist := Astrings;
End;

procedure tNames.setColornames(const Astrings: Tstringlist);
Begin
  // Peditionlist := Astrings;
End;

procedure tNames.setpressnames(const Astrings: Tstringlist);
Begin
  // Peditionlist := Astrings;
End;


function tNames.GetPublicationAlias(name: string) : string;
begin

  try
    PGetnames.Sql.Clear;
    PGetnames.Sql.Add('Select ShortName From InputAliases');
    PGetnames.Sql.Add('where ShortName<>'''' AND LongName = ' + QuotedStr(name) + ' AND Type=''Publication''');
   // PGetnames.Sql.SaveToFile('c:\\temp\\alias.sql');

    PGetnames.Open;
    if not PGetnames.Eof then
    begin
      result := Trim(PGetnames.Fields[0].AsString);
    end;
    PGetnames.Close;
  except
     //on E : Exception do
     //begin
     //  ShowMessage('Exception = '+E.ClassName + ' - ' + E.Message );
     //end;
  end;


end;
// aaaaaaaaaaaaaaaaaaaaaaaaaaa

Function tNames.productionrunIDtoname(ID: Integer): String;
var
  t: string;
begin
  t := '';
  if (ID <= 0) then
    exit;
  try
    PGetnames.Sql.Clear;
    PGetnames.Sql.Add('SELECT Name FROM ProductionNames WITH (NOLOCK) WHERE ProductionID=' + IntToStr(ID));
    PGetnames.open;
    if not PGetnames.eof then
    begin
      t := Trim(PGetnames.Fields[0].AsString);
    end;
    PGetnames.Close;

    result := t;

  finally

  end;
End;

Function tNames.productionrunnametoid(Name: string): Integer;
Begin
  result := -1;
  if (Trim(name) = '') then
    exit;

  PGetnames.Sql.Clear;
  PGetnames.Sql.Add ('SELECT ProductionID FROM ProductionNames WITH (NOLOCK) WHERE Name='+ QuotedStr(Trim(name)));
  PGetnames.open;
  if not PGetnames.eof then
  begin
    result := PGetnames.Fields[0].AsInteger;
  end;
  PGetnames.Close;
End;

(* Function tNames.Getproductionrunnames : TStringList;
  Begin
  result := Pproductionrunlist;
  End;
  procedure tNames.setproductionrunnames (const Astrings : TStringList);
  Begin
  //Pproductionrunlist := Astrings;
  End;
*)

Function tNames.pageformatIDtoname(ID: Integer): String;
Var
  I: Integer;
Begin
  result := '';
  For I := 1 to PNpageformats do
  begin
    IF Ppageformats[I].ID = ID then
    begin
      result := Ppageformats[I].Name;
      break;
    end;
  end;
End;

Function tNames.pageformatnametoid(Name: string): Integer;
Var
  I: Integer;
Begin
  result := -1;
  For I := 1 to PNpageformats do
  begin
    IF Ppageformats[I].Name = name then
    begin
      result := Ppageformats[I].ID;
      break;
    end;
  end;
End;

Function tNames.Getpageformatnames: Tstringlist;
Begin
  result := Ppageformatlist;
End;

procedure tNames.setpageformatnames(const Astrings: Tstringlist);
Begin
  // Ppageformatlist := Astrings;
End;

Function tNames.proofIDtoname(ID: Integer): String;
Var
  I: Integer;
Begin
  result := '';
  For I := 1 to PNproofs do
  begin
    IF Pproofs[I].ID = ID then
    begin
      result := Pproofs[I].Name;
      break;
    end;
  end;
End;

Function tNames.proofnametoid(Name: string): Integer;
Var
  I: Integer;
Begin
  result := -1;
  For I := 1 to PNproofs do
  begin
    IF Pproofs[I].Name = name then
    begin
      result := Pproofs[I].ID;
      break;
    end;
  end;
End;

Function tNames.Getproofnames: Tstringlist;
Begin
  result := Pprooflist;
End;

procedure tNames.setproofnames(const Astrings: Tstringlist);
Begin
  // Pprooflist := Astrings;
End;

Function tNames.locationIDtoname(ID: Integer): String;
Var
  I: Integer;
Begin
  result := '';
  For I := 1 to PNlocations do
  begin
    IF Plocations[I].ID = ID then
    begin
      result := Plocations[I].Name;
      break;
    end;
  end;
End;

Function tNames.locationnametoid(Name: string): Integer;
Var
  I: Integer;
Begin
  result := -1;
  For I := 1 to PNlocations do
  begin
    IF Plocations[I].Name = name then
    begin
      result := Plocations[I].ID;
      break;
    end;
  end;
End;

Function tNames.Getlocationnames: Tstringlist;
Begin
  result := Plocationlist;
End;

procedure tNames.setlocationnames(const Astrings: Tstringlist);
Begin
  // Plocationlist := Astrings;
End;

Function tNames.issueIDtoname(ID: Integer): String;
Var
  I: Integer;
Begin
  result := '';
  For I := 1 to PNissues do
  begin
    IF Pissues[I].ID = ID then
    begin
      result := Pissues[I].Name;
      break;
    end;
  end;
End;

Function tNames.sectionIDtoname(ID: Integer): String;
Var
  I: Integer;
Begin
  result := '';
  For I := 1 to PNsections do
  begin
    IF Psections[I].ID = ID then
    begin
      result := Psections[I].Name;
      break;
    end;
  end;
End;

Function tNames.PublicationIDtoNameReload(ID: Integer): String;
Begin
  result := publicationIDtoname(ID);
  if (result = '') then
  begin
    loadalist(4);
    result := publicationIDtoname(ID);

  end;

End;

Function tNames.publicationIDtoname(ID: Integer): String;
Var
  I: Integer;
Begin
  result := '';
  For I := 1 to PNPublications do
  begin
    IF PPublications[I].ID = ID then
    begin
      result := PPublications[I].Name;
      break;
    end;
  end;
End;

Function tNames.CustomerIDtoname(ID: Integer): String;
Var
  I: Integer;
Begin
  result := '';
  For I := 1 to PNCustomers do
  begin
    IF PCustomers[I].ID = ID then
    begin
      result := PCustomers[I].Name;
      break;
    end;
  end;
End;

Function tNames.FlatProofConfigurationIDtoname(ID: Integer): String;
Var
  I: Integer;
Begin
  result := '';
  For I := 1 to PNFlatProofConfigurations do
  begin
    IF PFlatProofConfigurations[I].ID = ID then
    begin
      result := PFlatProofConfigurations[I].Name;
      break;
    end;
  end;
End;

Function tNames.deviceIDtoname(ID: Integer): String;
Var
  I: Integer;
Begin
  result := '';
  For I := 1 to PNdevices do
  begin
    IF Pdevices[I].ID = ID then
    begin
      result := Pdevices[I].Name;
      break;
    end;
  end;
End;

Function tNames.issuenametoid(Name: string): Integer;
Var
  I: Integer;
Begin
  result := -1;
  For I := 1 to PNissues do
  begin
    IF Pissues[I].Name = name then
    begin
      result := Pissues[I].ID;
      break;
    end;
  end;
End;

Function tNames.sectionnametoid(Name: string): Integer;
Var
  I: Integer;
Begin
  result := -1;
  name := uppercase(name);
  For I := 1 to PNsections do
  begin
    IF uppercase(Psections[I].Name) = name then
    begin
      result := Psections[I].ID;
      break;
    end;
  end;
End;

Function tNames.publicationnametoid(Name: string): Integer;
Var
  I: Integer;
Begin
  result := -1;
  name := uppercase(name);
  For I := 1 to PNPublications do
  begin
    IF uppercase(PPublications[I].Name) = name then
    begin
      result := PPublications[I].ID;
      break;
    end;
  end;
End;

Function tNames.Customernametoid(Name: string): Integer;
Var
  I: Integer;
Begin
  result := -1;
  For I := 1 to PNCustomers do
  begin
    IF PCustomers[I].Name = name then
    begin
      result := PCustomers[I].ID;
      break;
    end;
  end;
End;

Function tNames.FlatProofConfigurationnametoid(Name: string): Integer;
Var
  I: Integer;
Begin
  result := -1;
  For I := 1 to PNFlatProofConfigurations do
  begin
    IF PFlatProofConfigurations[I].Name = name then
    begin
      result := PFlatProofConfigurations[I].ID;
      break;
    end;
  end;
End;

Function tNames.devicenametoid(Name: string): Integer;
Var
  I: Integer;
Begin
  result := -1;
  For I := 1 to PNdevices do
  begin
    IF Pdevices[I].Name = name then
    begin
      result := Pdevices[I].ID;
      break;
    end;
  end;
End;

Function tNames.Getissuenames: Tstringlist;
Begin
  result := Pissuelist;
End;

procedure tNames.setissuenames(const Astrings: Tstringlist);
Begin
  // Pissuelist := Astrings;
End;

Function tNames.Getsectionnames: Tstringlist;
Begin
  result := Psectionlist;
End;

procedure tNames.setsectionnames(const Astrings: Tstringlist);
Begin
  // Psectionlist := Astrings;
End;

Function tNames.Getpublicationnames: Tstringlist;
Begin
  result := Ppublicationlist;
End;

Function tNames.GetCustomernames: Tstringlist;
Begin
  result := PCustomerlist;
End;

Function tNames.GetFlatProofConfigurationnames: Tstringlist;
Begin
  result := PFlatProofConfigurationlist;
End;

(*
  Function tNames.Getdevicenames : TStringList;
  Begin
  result := Pdevicelist;
  End;
*)

procedure tNames.setpublicationnames(const Astrings: Tstringlist);
Begin
  // Ppublicationlist := Astrings;
End;

procedure tNames.setCustomernames(const Astrings: Tstringlist);
Begin
  // PCustomerlist := Astrings;
End;

procedure tNames.setFlatProofConfigurationnames(const Astrings: Tstringlist);
Begin
  // PFlatProofConfigurationlist := Astrings;
End;

(*
  procedure tNames.setdevicenames (const Astrings : TStringList);
  Begin
  //Pdevicelist := Astrings;
  End;
*)

Function tNames.Addname(Nametype: Integer; NewName: String): Boolean;

  procedure addit;
  Begin
    result := false;
    try
      PGetnames.execsql;
      result := true;
    except

    end;
  End;

Var
  NextIDnum: Integer;

Begin
  IF NewName = '' then
  begin
    result := false;
    exit;
  end;
  Case Nametype of
    1:
      Begin // edition

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Select top 1 editionID From editionnames');
        PGetnames.Sql.Add('order by editionID DESC');
        PGetnames.open;
        IF PGetnames.recordcount > 0 then
        Begin
          NextIDnum := PGetnames.fieldbyname('editionid').AsInteger + 1;
        End
        else
          NextIDnum := 1;

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Insert editionnames');
        PGetnames.Sql.Add('values (' + IntToStr(NextIDnum) + ',' + '''' +
          NewName + '''' + ',-1,-1)');

        addit;

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Select Name From editionnames');
        PGetnames.Sql.Add('where name = ' + '''' + NewName + '''');
        PGetnames.open;

        result := PGetnames.recordcount > 0;

        PGetnames.Close;

      End;

    2:
      Begin // issue      //Issue table
        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Select top 1 issueID From issuenames');
        PGetnames.Sql.Add('order by issueID DESC');
        PGetnames.open;
        IF PGetnames.recordcount > 0 then
        Begin
          NextIDnum := PGetnames.fieldbyname('issueid').AsInteger + 1;
        End
        else
          NextIDnum := 1;

        PGetnames.Close;

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Insert issuenames');
        PGetnames.Sql.Add('values (' + IntToStr(NextIDnum) + ',' + '''' +
          NewName + '''' + ')');
        addit;

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Select Name From issuenames');
        PGetnames.Sql.Add('where name = ' + '''' + NewName + '''');
        PGetnames.open;

        result := PGetnames.recordcount > 0;

        PGetnames.Close;

      end;
    3:
      Begin // pressrun
        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Select top 1 pressrunID From pressrunnames');
        PGetnames.Sql.Add('order by pressrunID DESC');
        PGetnames.open;
        IF PGetnames.recordcount > 0 then
        Begin
          NextIDnum := PGetnames.fieldbyname('pressrunid').AsInteger + 1;
        End
        else
          NextIDnum := 1;

        PGetnames.Close;

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Insert pressrunnames');
        PGetnames.Sql.Add('values (' + IntToStr(NextIDnum) + ',' + '''' +
          NewName + '''' + ')');
        addit;

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Select name From pressrunnames');
        PGetnames.Sql.Add('where name = ' + '''' + NewName + '''');
        PGetnames.open;

        result := PGetnames.recordcount > 0;

        PGetnames.Close;

      End;
    4:
      Begin // publication
        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Select top 1 publicationID From publicationnames');
        PGetnames.Sql.Add('order by publicationID DESC');
        PGetnames.open;
        IF PGetnames.recordcount > 0 then
        Begin
          NextIDnum := PGetnames.fieldbyname('publicationid').AsInteger + 1;
        End
        else
          NextIDnum := 1;

        PGetnames.Close;

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Insert publicationnames (PublicationID,Name)');
        PGetnames.Sql.Add('values (' + IntToStr(NextIDnum) + ',' + '''' +
          NewName + '''' + ')');
        addit;

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Select Name From publicationnames');
        PGetnames.Sql.Add('where name = ' + '''' + NewName + '''');
        PGetnames.open;

        result := PGetnames.recordcount > 0;

        PGetnames.Close;

      End;
    5:
      Begin // section
        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Select top 1 sectionID From sectionnames');
        PGetnames.Sql.Add('order by sectionID DESC');
        PGetnames.open;
        IF PGetnames.recordcount > 0 then
        Begin
          NextIDnum := PGetnames.fieldbyname('sectionid').AsInteger + 1;
        End
        else
          NextIDnum := 1;

        PGetnames.Close;

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Insert sectionnames');
        PGetnames.Sql.Add('values (' + IntToStr(NextIDnum) + ',' + '''' +
          NewName + '''' + ')');
        addit;

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Select Name From sectionnames');
        PGetnames.Sql.Add('where name = ' + '''' + NewName + '''');
        PGetnames.open;

        result := PGetnames.recordcount > 0;

        PGetnames.Close;

      End;
    6:
      Begin // pagetemplate
        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Select top 1 pagetemplateID From pagetemplatenames');
        PGetnames.Sql.Add('order by pagetemplateID DESC');
        PGetnames.open;
        IF PGetnames.recordcount > 0 then
        Begin
          NextIDnum := PGetnames.fieldbyname('pagetemplateid').AsInteger + 1;
        End
        else
          NextIDnum := 1;

        PGetnames.Close;

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Insert pagetemplatenames');
        PGetnames.Sql.Add('values (' + IntToStr(NextIDnum) + ',' + '''' +
          NewName + '''' + ')');
        addit;

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Select Name From pagetemplatenames');
        PGetnames.Sql.Add('where name = ' + '''' + NewName + '''');
        PGetnames.open;

        result := PGetnames.recordcount > 0;

        PGetnames.Close;

      End;
    7:
      Begin // location
        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Select top 1 locationID From locationnames');
        PGetnames.Sql.Add('order by locationID DESC');
        PGetnames.open;
        IF PGetnames.recordcount > 0 then
        Begin
          NextIDnum := PGetnames.fieldbyname('locationid').AsInteger + 1;
        End
        else
          NextIDnum := 1;
        PGetnames.Close;

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Insert locationnames');
        PGetnames.Sql.Add('values (' + IntToStr(NextIDnum) + ',' + '''' +
          NewName + '''' + ')');
        addit;

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Select Name From locationnames');
        PGetnames.Sql.Add('where name = ' + '''' + NewName + '''');
        PGetnames.open;
        result := PGetnames.recordcount > 0;
        PGetnames.Close;

      End;
    8:
      Begin // proof
        MessageDlg
          ('proof configurations cannot be entered in production planner',
          mtInformation, [mbOk], 0);

      End;

    9:
      Begin // productionrun

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Select top 1 productionID From productionnames');
        PGetnames.Sql.Add('order by productionID DESC');
        PGetnames.open;
        IF PGetnames.recordcount > 0 then
          NextIDnum := PGetnames.Fields[0].AsInteger + 1
        else
          NextIDnum := 1;
        PGetnames.Close;

        PGetnames.Sql.Clear;
        // PGetnames.sql.add('Insert productionnames (productionID,name,plantype)');
        // PGetnames.sql.add('values ('+inttostr(NextIDnum)+ ','+''''+NewName+''''+',1)');

        PGetnames.Sql.Add('DECLARE @ProductionID int');
        PGetnames.Sql.Add
          ('IF NOT EXISTS (SELECT ProductionID FROM ProductionNames WHERE ProductionID = 1)');
        PGetnames.Sql.Add('  SET @ProductionID = 1');
        PGetnames.Sql.Add('ELSE');
        PGetnames.Sql.Add('BEGIN');
        PGetnames.Sql.Add
          ('	SET @ProductionID = (SELECT MIN(P1.ProductionID+1) FROM ProductionNames AS P1 WHERE NOT EXISTS (SELECT ProductionID FROM ProductionNames AS P2 WHERE P1.ProductionID+1=P2.ProductionID))');
        PGetnames.Sql.Add('		IF  @ProductionID IS  NULL');
        PGetnames.Sql.Add('			SET @ProductionID=1');
        PGetnames.Sql.Add('END');
        PGetnames.Sql.Add
          ('INSERT INTO ProductionNames (productionID,name,plantype)');
        PGetnames.Sql.Add('values (@ProductionID,' + '''' + NewName +
          '''' + ',1)');

        addit;

        PGetnames.Sql.Clear;
        PGetnames.Sql.Add('Select Name From productionnames');
        PGetnames.Sql.Add('where name = ' + '''' + NewName + '''');
        PGetnames.open;

        result := PGetnames.recordcount > 0;

        PGetnames.Close;

      End;

  end;
  loadalist(Nametype);
End;

Function tNames.pagetemplateIDtoname(ID: Integer): String;
Var
  I: Integer;
Begin
  result := '';
  For I := 1 to PNpagetemplates do
  begin
    IF Ppagetemplates[I].ID = ID then
    begin
      result := Ppagetemplates[I].Name;
      break;
    end;
  end;
End;

Function tNames.pagetemplatenametoid(Name: string): Integer;
Var
  I: Integer;
Begin
  result := -1;
  For I := 1 to PNpagetemplates do
  begin
    IF Ppagetemplates[I].Name = name then
    begin
      result := Ppagetemplates[I].ID;
      break;
    end;
  end;
End;

Function tNames.Getpagetemplatenames: Tstringlist;
Begin
  result := Ppagetemplatelist;
End;

procedure tNames.setpagetemplatenames(const Astrings: Tstringlist);
Begin
  // Ppagetemplatelist := Astrings;
End;

Procedure tNames.initializedb(Var ASQLQueryname: TSQLQuery);
Begin
  IF PGetnames = nil then
    PGetnames := ASQLQueryname;
  PGetnames.Active := false;

End;

Function tNames.GetorderOftype(Nametype: Longint; NameID: Longint): Longint;

  Function SearchInNameType(Var Anametype: Tnamedatatype; Anamelength: Integer;
    AnameID: Longint): Longint;
  Var
    I: Longint;
  Begin
    result := 0;
    For I := 1 to Anamelength do // namedataSize do
    begin
      IF Anametype[I].ID = AnameID then
      begin
        result := I;
        break;
      end;
    end;
  end;

Begin
  result := 0;
  Case Nametype OF
    1:
      begin
        result := SearchInNameType(Peditions, PNeditions, NameID);
      end;
    2:
      begin
        result := SearchInNameType(Pissues, PNissues, NameID);
      end;
    4:
      begin
        result := SearchInNameType(PPublications, PNPublications, NameID);
      end;
    5:
      begin
        result := SearchInNameType(Psections, PNsections, NameID);
      end;
    7:
      begin
        result := SearchInNameType(Plocations, PNlocations, NameID);
      end;
    8:
      begin
        result := SearchInNameType(Pproofs, PNproofs, NameID);
      end;
    11:
      begin
        result := SearchInNameType(Pdevices, PNdevices, NameID);
      end;
    12:
      begin
        result := SearchInNameType(PFlatProofConfigurations,
          PNFlatProofConfigurations, NameID);
      end;
    13:
      begin
        result := SearchInNameType(PCustomers, PNCustomers, NameID);
      end;
    98:
      begin
        result := SearchInNameType(PEvents, PNEvents, NameID);
      end;
    // 99 : begin
    // result := SearchInNameType(FileServerNames,NameID);
    // end;
    100:
      begin
        result := SearchInNameType(Pcolornames, PNcolornames, NameID);
      end;
    110:
      begin
        result := SearchInNameType(Ppressnames, PNpressnames, NameID);
      end;
    120:
      begin
        result := SearchInNameType(Ppageformats, PNpageformats, NameID);
      end;

  end;
end;

Function tNames.eventnumberfromname(Name: string): Integer;
Var
  I: Integer;
Begin
  result := -1;
  For I := 1 to PNEvents do
  begin
    IF PEvents[I].Name = name then
    begin
      result := PEvents[I].ID;
      break;
    end;
  end;
End;

Function tNames.eventnamefromnumber(ID: Integer): string;
Var
  I: Integer;
Begin
  result := '';
  For I := 1 to PNEvents do
  begin
    IF PEvents[I].ID = ID then
    begin
      result := PEvents[I].Name;
      break;
    end;
  end;
End;

Function tNames.GetEventNames: Tstringlist;
Begin
  result := PEventList;
End;

procedure tNames.SetEventNames(const Astrings: Tstringlist);
Begin
  // PEventList := Astrings;
End;

// NOTE: Will return PlanCenter server if exists
function tNames.GetMainFileServer: string;
var
  I: Integer;
begin
  result := GetPlanCenterFileServer;
  if (result = '') then
  begin
    for I := 1 to NFileServerNames do
    begin
      if (FileServerNames[I].Servertype = 1) then
      begin
        result := FileServerNames[I].Name;
        break;
      end;

    end;
  end;
end;

function tNames.GetPlanCenterFileServer: string;
var
  I: Integer;
begin
  result := '';
  for I := 1 to NFileServerNames do
  begin
    if (FileServerNames[I].Servertype = Prefs.PlanCenterFileServerType) then
    begin
      result := FileServerNames[I].Name;
      break;
    end;

  end;
end;

// NOTE: Will return PlanCenter server if exists
function tNames.GetMainFileServerShare: string;
var
  I: Integer;
begin

  result := GetPlanCenterFileServerShare;
  if (result = '') then
  begin
    for I := 1 to NFileServerNames do
    begin
      if (FileServerNames[I].Servertype = 1) then
      begin
        result := FileServerNames[I].FullPath;
        break;
      end;
    end;
  end;
end;

function tNames.GetPlanCenterFileServerShare: string;
var
  I: Integer;
begin
  result := '';
  for I := 1 to NFileServerNames do
  begin
    if (FileServerNames[I].Servertype = Prefs.PlanCenterFileServerType) then
    begin
      result := FileServerNames[I].FullPath;
      break;
    end;

  end;
end;

(*
procedure tNames.LoadUsers;
Var
  T : string;
  i{,AadminN} : integer;
Begin
  if true then
  begin
    i:= 0;
    PGetnames.SQL.Clear;
    PGetnames.SQL.Add('Select count(username) from usernames');
    PGetnames.Open;
    IF not PGetnames.Eof then
    begin
      i := PGetnames.Fields[0].AsInteger;
    End;
    PGetnames.Close;

    i := (i +10) * 2;
    IF i < 200 then
      i := 200;
    maxusers := i;
    setlength(users,i);
    Nusers := 0;
    ComboBoxusername.Items.clear;
    PGetnames.SQL.clear;
    PGetnames.SQL.Add('SELECT username,password,usergroupid,email,pagesperrow,refreshtime,accountenabled,fullname FROM UserNames');
    PGetnames.SQL.Add('ORDER BY username');
   PGetnames.Open;
    While not PGetnames.Eof do
    begin
      users[Nusers].Username        := PGetnames.Fields[0].AsString;
      ComboBoxusername.Items.Add(users[Nusers].Username);
      users[Nusers].password        := TUtils.DecodeBlowfish(DataM1.Query1.Fields[1].AsString);
      users[Nusers].usergroupid     := PGetnames.Fields[2].AsInteger;
      users[Nusers].email           := PGetnames.Fields[3].AsString;
      users[Nusers].pagesperrow     := PGetnames.Fields[4].AsInteger;
      users[Nusers].refreshtime     := PGetnames.Fields[5].AsInteger;
      users[Nusers].accountenabled  := PGetnames.Fields[6].AsInteger;
      users[Nusers].fullname        := PGetnames.Fields[7].AsString;
      Inc(Nusers);
      PGetnames.Next;
    end;
    PGetnames.Close;
    For i := 0 to Nusers-1 do
    begin
      PGetnames.SQL.Clear;
      PGetnames.SQL.Add('SELECT UserGroupName,IsAdmin,MayConfigure,MayReImage,MayKillColor,MayRunProducts,MayDeleteProducts,MayApprove FROM UserGroupNames');
      PGetnames.SQL.Add('WHERE UserGroupID = ' + IntToStr(users[i].UserGroupId));
      PGetnames.Open;
      While not PGetnames.Eof do
      begin
        users[i].usergroupname      := PGetnames.Fields[0].AsString;
        users[i].isadmin            := PGetnames.Fields[1].AsInteger = 1;
        users[i].MayConfigure       := PGetnames.Fields[2].AsInteger = 1;
        users[i].MayReImage         := PGetnames.Fields[3].AsInteger = 1;
        users[i].MayKillColor       := PGetnames.Fields[4].AsInteger = 1;
        users[i].MayRunProducts     := PGetnames.Fields[5].AsInteger = 1;
        users[i].MayDeleteProducts  := PGetnames.Fields[6].AsInteger = 1;
        users[i].MayApprove         := PGetnames.Fields[7].AsInteger = 1;
        users[i].readonly           := users[i].UserGroupId = 4;
        T := uppercase(users[i].usergroupname);
        users[i].issuper := (users[i].MayConfigure) or (users[i].MayRunProducts) or (pos('SUPER',T)>0);
        PGetnames.Next;
      end;
      PGetnames.close;
    End;
    ComboBoxusername.Itemindex := 0;
  End;
End;

*)

end.
