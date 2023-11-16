object DataM1: TDataM1
  Height = 530
  Width = 727
  object Query1: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 660
    Top = 28
  end
  object Query2: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 664
    Top = 88
  end
  object Queryapplypressrun: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'pagination'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'LocationID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'proofid'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PressRunID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'TemplateID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PagePosition'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PageType'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PagesOnPlate'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'SheetNumber'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'SheetSide'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PressID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PressSectionNumber'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'CopyFlatSeparationset'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'CopySeparationset'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'FlatSeparationset'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Separationset'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Separation'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'FlatSeparation'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'copynumber'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'uniquepage'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'active'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'stackpos'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'tower'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'cylinder'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'zone'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'high'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Approved'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Hold'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'pageindex'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'MasterCopySeparationSet'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'OrgSeparation'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'OrgFlatSeparation'
        ParamType = ptUnknown
      end>
    SQL.Strings = (
      'update pagetable'
      'Set'
      'pagination = :pagination,'
      'LocationID = :LocationID,'
      'proofid = :proofid,'
      'PressRunID = :PressRunID,'
      'TemplateID = :TemplateID,'
      'PagePosition = :PagePosition,'
      'PageType = :PageType,'
      'PagesOnPlate = :PagesOnPlate,'
      'SheetNumber = :SheetNumber,'
      'SheetSide = :SheetSide,'
      'PressID = :PressID,'
      'PressSectionNumber = :PressSectionNumber,'
      'CopyFlatSeparationset = :CopyFlatSeparationset,'
      'CopySeparationset = :CopySeparationset,'
      'FlatSeparationset = :FlatSeparationset,'
      'Separationset = :Separationset,'
      'Separation = :Separation,'
      'FlatSeparation = :FlatSeparation,'
      'copynumber = :copynumber,'
      'uniquepage = :uniquepage,'
      'active = :active,'
      'Sortingposition = :stackpos,'
      'presstower = :tower,'
      'Presscylinder = :cylinder,'
      'presszone = :zone,'
      'Presshighlow = :high,'
      'Approved = :Approved,'
      'Hold = :Hold,'
      'pageindex =:pageindex,'
      'MasterCopySeparationSet = :MasterCopySeparationSet'
      'Where'
      
        'Separation = :OrgSeparation and FlatSeparation = :OrgFlatSeparat' +
        'ion')
    SQLConnection = CRSQLConnectionplan
    Left = 272
    Top = 332
  end
  object SQLQueryname: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'CopySeparationSet'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'SeparationSet'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Separation'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'CopyFlatSeparationSet'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'FlatSeparationSet'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'FlatSeparation'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Status'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'ExternalStatus'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PublicationID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'SectionID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'EditionID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'LocationID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PressRunID'
        ParamType = ptUnknown
      end
      item
        DataType = ftDateTime
        Name = 'PubDate'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'PageName'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'Color'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'TemplateID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'ProofID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'DeviceID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Version'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Layer'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'CopyNumber'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Pagination'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Approved'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Hold'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Active'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Priority'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PagePosition'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PageType'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PagesOnPlate'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'SheetNumber'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'SheetSide'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PressID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PressSectionNumber'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'productionID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'issueid'
        ParamType = ptUnknown
      end>
    SQL.Strings = (
      'insert pagetable (CopySeparationSet,'
      'SeparationSet,'
      'Separation,'
      'CopyFlatSeparationSet,'
      'FlatSeparationSet,'
      'FlatSeparation,'
      'Status,'
      'ExternalStatus,'
      'PublicationID,'
      'SectionID,'
      'EditionID,'
      'LocationID,'
      'PressRunID,'
      'PubDate,'
      'PageName,'
      'Color,'
      'TemplateID,'
      'ProofID,'
      'DeviceID,'
      'Version,'
      'Layer,'
      'CopyNumber,'
      'Pagination,'
      'Approved,'
      'Hold,'
      'Active,'
      'Priority,'
      'PagePosition,'
      'PageType,'
      'PagesOnPlate,'
      'SheetNumber,'
      'SheetSide,'
      'PressID,'
      'PressSectionNumber,'
      'productionID,'
      'issueid)'
      ''
      'values'
      '(:CopySeparationSet,'
      ':SeparationSet,'
      ':Separation,'
      ':CopyFlatSeparationSet,'
      ':FlatSeparationSet,'
      ':FlatSeparation,'
      ':Status,'
      ':ExternalStatus,'
      ':PublicationID,'
      ':SectionID,'
      ':EditionID,'
      ':LocationID,'
      ':PressRunID,'
      ':PubDate,'
      ':PageName,'
      ':Color,'
      ':TemplateID,'
      ':ProofID,'
      ':DeviceID,'
      ':Version,'
      ':Layer,'
      ':CopyNumber,'
      ':Pagination,'
      ':Approved,'
      ':Hold,'
      ':Active,'
      ':Priority,'
      ':PagePosition,'
      ':PageType,'
      ':PagesOnPlate,'
      ':SheetNumber,'
      ':SheetSide,'
      ':PressID,'
      ':PressSectionNumber,'
      ':productionID,'
      ':issueid)')
    SQLConnection = CRSQLConnectionplan
    Left = 272
    Top = 260
  end
  object Query3: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 664
    Top = 144
  end
  object SQLQuerypage: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 276
    Top = 204
  end
  object QueryapplypressrunChanges: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'deviceid'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'publicationid'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'sectionid'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'issueid'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'editionid'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'pagination'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'LocationID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PressRunID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'TemplateID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PagePosition'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PageType'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PagesOnPlate'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'SheetNumber'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'SheetSide'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PressID'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'PressSectionNumber'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'CopyFlatSeparationset'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'CopySeparationset'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'FlatSeparationset'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Separationset'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Separation'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'FlatSeparation'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'copynumber'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'uniquepage'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'active'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'stackpos'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'tower'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'cylinder'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'zone'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'high'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Approved'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'Hold'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'pageindex'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'MasterCopySeparationSet'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'OrgSeparation'
        ParamType = ptUnknown
      end>
    SQL.Strings = (
      'update pagetable'
      'Set'
      'deviceid = :deviceid,'
      'publicationid = :publicationid,'
      'sectionid = :sectionid,'
      'issueid = :issueid,'
      'editionid = :editionid,'
      'pagination = :pagination,'
      'LocationID = :LocationID,'
      'PressRunID = :PressRunID,'
      'TemplateID = :TemplateID,'
      'PagePosition = :PagePosition,'
      'PageType = :PageType,'
      'PagesOnPlate = :PagesOnPlate,'
      'SheetNumber = :SheetNumber,'
      'SheetSide = :SheetSide,'
      'PressID = :PressID,'
      'PressSectionNumber = :PressSectionNumber,'
      'CopyFlatSeparationset = :CopyFlatSeparationset,'
      'CopySeparationset = :CopySeparationset,'
      'FlatSeparationset = :FlatSeparationset,'
      'Separationset = :Separationset,'
      'Separation = :Separation,'
      'FlatSeparation = :FlatSeparation,'
      'copynumber = :copynumber,'
      'uniquepage = :uniquepage,'
      'active = :active,'
      'Sortingposition = :stackpos,'
      'presstower = :tower,'
      'Presscylinder = :cylinder,'
      'presszone = :zone,'
      'Presshighlow = :high,'
      'Approved = :Approved,'
      'Hold = :Hold,'
      'pageindex =:pageindex,'
      'MasterCopySeparationSet = :MasterCopySeparationSet'
      'Where'
      'Separation = :OrgSeparation')
    SQLConnection = CRSQLConnectionplan
    Left = 528
    Top = 272
  end
  object SQLQueryTmp: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 384
    Top = 140
  end
  object SQLQueryTestserver: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'Select servername from GeneralPreferences (NOLOCK) ')
    SQLConnection = CRSQLConnectionplan
    Left = 384
    Top = 24
  end
  object Query4: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 668
    Top = 204
  end
  object Query5: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 668
    Top = 260
  end
  object CRSQLConnectionplan: TSQLConnection
    ConnectionName = 'CRSQLConnectionplan'
    DriverName = 'DevartSQLServerDirect'
    LoginPrompt = False
    Params.Strings = (
      'SchemaOverride=%.dbo'
      'DriverUnit=DBXDevartSQLServer'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver270.' +
        'bpl'
      
        'MetaDataPackageLoader=TDBXDevartMSSQLMetaDataCommandFactory,DbxD' +
        'evartSQLServerDriver270.bpl'
      'ProductName=DevartSQLServer'
      'GetDriverFunc=getSQLDriverSQLServerDirect'
      'LibraryName=dbexpsda41.dll'
      'VendorLib=not used'
      'LibraryNameOsx=libdbexpsda41.dylib'
      'VendorLibOsx=not used'
      'Port=1433'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'MaxBlobSize=-1'
      'LongStrings=True'
      'EnableBCD=True'
      'FetchAll=False'
      'ParamPrefix=False'
      'UseUnicode=True'
      'IPVersion=IPv4'
      'UseQuoteChar=True'
      'BlobSize=-1'
      'HostName='
      'DataBase='
      'User_Name='
      'Password=')
    Left = 76
    Top = 376
  end
  object Querytree: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 392
    Top = 312
  end
  object SQLQueryTreethread: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLConnectionTreestate
    Left = 160
    Top = 28
  end
  object Queryautorefresh1: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 268
    Top = 28
  end
  object SQLQueryTestATry: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'Select servername from GeneralPreferences (NOLOCK) ')
    SQLConnection = CRSQLConnectionplan
    Left = 384
    Top = 80
  end
  object SQLQueryplateupd: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 272
    Top = 80
  end
  object SQLQueryAnyplate: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 276
    Top = 388
  end
  object SQLQuerydevcontrol: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLConnectionDeviceState
    Left = 520
    Top = 212
  end
  object SQLQueryMplateupd: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 512
    Top = 36
  end
  object SQLQuerytreecash: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 572
    Top = 408
  end
  object SQLQuerytreecashUpd: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 424
    Top = 404
  end
  object SQLQueryconsole: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 516
    Top = 96
  end
  object SQLQuerypagetable: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 276
    Top = 148
  end
  object SQLQuerySJO1: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from PressRunOutputMethod')
    SQLConnection = CRSQLConnectionplan
    Left = 672
    Top = 324
  end
  object QueryProductionStatus1: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = CRSQLConnectionplan
    Left = 516
    Top = 156
  end
  object QueryWorkerThreadUnknownPages: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from PressRunOutputMethod')
    SQLConnection = SQLConnectionErrorFileThread
    Left = 520
    Top = 332
  end
  object SQLConnectionErrorFileThread: TSQLConnection
    ConnectionName = 'CRSQLConnectionErrorFileThread'
    DriverName = 'DevartSQLServerDirect'
    LoginPrompt = False
    Params.Strings = (
      'SchemaOverride=%.dbo'
      'DriverUnit=DBXDevartSQLServer'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver270.' +
        'bpl'
      
        'MetaDataPackageLoader=TDBXDevartMSSQLMetaDataCommandFactory,DbxD' +
        'evartSQLServerDriver270.bpl'
      'ProductName=DevartSQLServer'
      'GetDriverFunc=getSQLDriverSQLServerDirect'
      'LibraryName=dbexpsda41.dll'
      'VendorLib=not used'
      'LibraryNameOsx=libdbexpsda41.dylib'
      'VendorLibOsx=not used'
      'Port=1433'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'MaxBlobSize=-1'
      'LongStrings=True'
      'EnableBCD=True'
      'FetchAll=False'
      'ParamPrefix=False'
      'UseUnicode=True'
      'IPVersion=IPv4'
      'UseQuoteChar=True'
      'BlobSize=-1'
      'HostName='
      'DataBase='
      'User_Name='
      'Password=')
    Left = 76
    Top = 320
  end
  object SQLConnectionTreestate: TSQLConnection
    ConnectionName = 'SQLConnectionTreeState'
    DriverName = 'DevartSQLServerDirect'
    LoginPrompt = False
    Params.Strings = (
      'SchemaOverride=%.dbo'
      'DriverUnit=DBXDevartSQLServer'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver270.' +
        'bpl'
      
        'MetaDataPackageLoader=TDBXDevartMSSQLMetaDataCommandFactory,DbxD' +
        'evartSQLServerDriver270.bpl'
      'ProductName=DevartSQLServer'
      'GetDriverFunc=getSQLDriverSQLServerDirect'
      'LibraryName=dbexpsda41.dll'
      'VendorLib=not used'
      'LibraryNameOsx=libdbexpsda41.dylib'
      'VendorLibOsx=not used'
      'Port=1433'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'MaxBlobSize=-1'
      'LongStrings=True'
      'EnableBCD=True'
      'FetchAll=True'
      'ParamPrefix=False'
      'UseUnicode=True'
      'IPVersion=IPv4'
      'UseQuoteChar=True'
      'BlobSize=-1'
      'HostName='
      'DataBase='
      'User_Name='
      'Password=')
    Left = 76
    Top = 432
  end
  object SQLConnectionDeviceState: TSQLConnection
    ConnectionName = 'CRSQLConnectionDeviceState'
    DriverName = 'DevartSQLServerDirect'
    LoginPrompt = False
    Params.Strings = (
      'SchemaOverride=%.dbo'
      'DriverUnit=DBXDevartSQLServer'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver280.' +
        'bpl'
      
        'MetaDataPackageLoader=TDBXDevartMSSQLMetaDataCommandFactory,DbxD' +
        'evartSQLServerDriver280.bpl'
      'ProductName=DevartSQLServer'
      'GetDriverFunc=getSQLDriverSQLServerDirect'
      'LibraryName=dbexpsda41.dll'
      'VendorLib=not used'
      'LibraryNameOsx=libdbexpsda41.dylib'
      'VendorLibOsx=not used'
      'Port=1433'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'MaxBlobSize=-1'
      'LongStrings=True'
      'EnableBCD=True'
      'FetchAll=True'
      'ParamPrefix=False'
      'UseUnicode=True'
      'IPVersion=IPv4'
      'UseQuoteChar=True'
      'BlobSize=-1'
      'HostName='
      'DataBase='
      'User_Name='
      'Password=')
    Left = 84
    Top = 232
  end
end
