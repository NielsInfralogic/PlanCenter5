unit Unitcalculateimpo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
Const
  MAXPAGES			 =		32;
  MAXSECTIONS		 =  	200;
  MAXFLATS			 =		100;
  MAXCOLORS			 =		16;
  MAXTEMPLATES   =    100;

  PRODUCTIONSTATE_HELD		= 0;
  PRODUCTIONSTATE_RUNNING	=	1;
  PRODUCTIONSTATE_DONE		=2;
  PRODUCTIONSTATE_ERROR		=3;


  PLATEREFERENCE_TOPLEFT		=0;
  PLATEREFERENCE_TOPRIGHT		=1;
  PLATEREFERENCE_BOTTOMLEFT	=2;
  PLATEREFERENCE_BOTTOMRIGHT	=3;

  PAGETYPE_NORMAL				=0;
  PAGETYPE_PANORAMA			=1;
  PAGETYPE_ANTIPANORAMA	 =	2;
  PAGETYPE_DUMMY				=3;

  BINDING_SADDLESTITCHED =		0;
  BINDING_PERFECTBOUND	 =	1;

  COLLATE_SEPARATE			=0;
  COLLATE_INSERT				=1;

  HALFWEBTYPE_NORMAL		 =	0;
  HALFWEBTYPE_WORKANDTURN	=	1;

  STATUSNUMBER_MISSING		 =	0;
  STATUSNUMBER_POLLING			=5;
  STATUSNUMBER_POLLINGERROR	 =	6;
  STATUSNUMBER_POLLED				=10;
  STATUSNUMBER_RESAMPLING		 =	15;
  STATUSNUMBER_RESAMPLINGERROR =	16;
  STATUSNUMBER_READY				=20;
  STATUSNUMBER_TRANSMITTING	 =	25;
  STATUSNUMBER_TRANSMISSIONERROR=	26;
  STATUSNUMBER_TRANSMITTED	 =	30;
  STATUSNUMBER_ASSEMBLING			=35;
  STATUSNUMBER_ASSEMBLINGERROR =	36;
  STATUSNUMBER_ASSEMBLED			=40;
  STATUSNUMBER_IMAGING			=45;
  STATUSNUMBER_IMAGINGERROR	 =	46;
  STATUSNUMBER_IMAGED				=50;
  STATUSNUMBER_VERIFYING		 =	55;
  STATUSNUMBER_VERIFYERROR		=56;
  STATUSNUMBER_VERIFIED			=60;
  STATUSNUMBER_KILLED				=99;




type
  COUTPUTPROCESSSTRUCT = record
                           m_ID : Integer;
                           m_templatename : String;
                           m_pressid : Integer;
                           m_pagesacross : Integer;
                           m_pagesdown : Integer;
                           m_pagerotation : array[0..MAXPAGES] of integer;
                           m_platereference : Integer;
                           m_pagenumbersfront : array[0..MAXPAGES] of integer;
                           m_pagenumbersback : array[0..MAXPAGES] of integer;
                           m_pagenumbersfronthalfweb : array[0..MAXPAGES] of integer;
                           m_pagenumbersbackhalfweb : array[0..MAXPAGES] of integer;
                           m_rotateback : boolean;
                         End;

  Cm_TemplateList = Array[0..MAXTEMPLATES] of COUTPUTPROCESSSTRUCT;


  CPFlat = ^CFlat;
  CFlat = record
            bIsDualSided : boolean;							                  // Single/dual sided signature
            nPagesPerSide : Integer;							                // Possible page positions per side (incl. dummies)
            apages : array[0..(MAXPAGES+1)*2] of integer;					// Signature master for front side followed by back side
            aFinalPages : array[0..(MAXPAGES+1)*2] of integer;		// Final numbers for both sides - front followed by back
            aFinalPageNames : array[0..(MAXPAGES+1)*2] of string;	// Final names for both sides - front followed by back
          End;

  CPSection = ^CSection;
  CSection = record
               nPagesInSection     : Integer; // := 0;
               nBindingStyle       : Integer; //1
               nFlatsInSection     : Integer; //0
               nStartingPageNumber : Integer; //1
               nHalfWebPage        : Integer; //0
               nHalfWebPage2       : Integer; //0
               Aflats	             : array[0..MAXFLATS+1] of CFlat;  // Placeholder for the flats
             End;


  Cpproduction = ^CProduction;
  CProduction = record
                  nPagesInProduction    : integer;            // Actual pages in whole job (excluding dummies)
                  nSectionsInProduction : Integer;         // Number of sections in production
                  nGeneralPageOffset    : Integer;            // Start number for whole production
                  nCollectionMode       : Integer;               // 0: Insert sections,  1: Perfect bound sections
                  nMaxFlatsPerSection   : Integer;
                  m_bIsConsecutiveNumbering : Integer;

                  aSections : Array[0..MAXSECTIONS+1] of csection;// Placeholder for the section (CHANGE TO A VECTOR SOME DAY)
                End;








  TForm1 = class(TForm)
    Button1: TButton;
  private
    { Private declarations }
  public
    Function Calculate:boolean;
    Function AdjustSectionHalfweb(sec             : Integer;
                                  Var pSection    : CSection;
                                  nPageNumber : Integer):integer;

    Function CountUniquePages(Var pFlat : CFlat):Integer;
    Function calculateSection(sec         : Integer;
                              Var Psection    : CSection;
                              nPageOffset : Integer):integer;

  end;

var
  Form1: TForm1;




  g_nSections : Integer;
  g_nPagesInSection : Array[0..MAXSECTIONS] of integer;
  g_nStartingPageInSection : Array[0..MAXSECTIONS] of integer;

  g_nInitialPageNumbersInSection : Array[0..MAXSECTIONS,1..MAXPAGES*MAXFLATS] of integer;
  g_nLogicalPageNumbersInSection : Array[0..MAXSECTIONS,1..MAXPAGES*MAXFLATS] of integer;
  g_nInitialPagesInSection : Array[0..MAXSECTIONS] of integer;


  g_nSectionIDList : Array[0..MAXSECTIONS] of integer;
  g_nHalfWebPageNumber : Array[0..MAXSECTIONS] of integer;
  g_nHalfWebPageNumber2 : Array[0..MAXSECTIONS] of integer;

  g_nPagesPerSideInFlats : Array[0..MAXSECTIONS,1..MAXFLATS] of integer;
  g_nSidesPerFlatInSection :  Array[0..MAXSECTIONS,1..MAXFLATS] of boolean;
  g_nFinalPageNames : Array[0..MAXSECTIONS,1..MAXFLATS,1..MAXPAGES] of string;
  g_nFinalPageNamesInternal : Array[0..MAXSECTIONS,1..MAXFLATS,1..MAXPAGES] of string;
  g_nFinalPageNumbers : Array[0..MAXSECTIONS,1..MAXFLATS,1..MAXPAGES] of Integer;
  g_nFinalPageNumbersInternal : Array[0..MAXSECTIONS,1..MAXFLATS,1..MAXPAGES] of Integer;
  g_nFlatsInSection : Array[0..MAXSECTIONS] of integer;
  g_sFinalPageColors : Array[0..MAXSECTIONS,1..MAXFLATS,1..MAXPAGES] of string;




implementation

{$R *.dfm}
Var
  m_presstemplatename : string;
	m_template : string;
  m_TemplateList : Cm_TemplateList;
	m_bindingstyle : Boolean;
	m_multipleruns : boolean;
	m_pagerange : String;
	m_collation : boolean;
	m_isDrawing : boolean;
	m_templateIdx : Integer;
	m_templateID : Integer;

	m_pProduction : CProduction;

Function Tform1.CountUniquePages(Var pFlat : CFlat):Integer;
Var
  npages : Integer;
  aPages : array[1..(MAXPAGES+1)*2] of integer;
  pp,nPagesToCount,p,thisNumber : integer;

Begin

	npages := 0;

  IF pFlat.bIsDualSided then
    nPagesToCount := 2 * pFlat.nPagesPerSide
  else
    nPagesToCount := pFlat.nPagesPerSide;

  For p := 1 to nPagesToCount do
		aPages[p] := pFlat.apages[p];

  For p := 1 to nPagesToCount do
  Begin
    thisNumber := aPages[p];
    if (thisNumber <> 0) then
    Begin
      Inc(nPages);
      For pp := p to nPagesToCount do
      begin
        if aPages[pp] = thisNumber then
          aPages[pp] := 0;
      end;
    End;
  end;

  result := nPages;
end;



Function tform1.calculateSection(sec             : Integer;
                                 Var Psection    : CSection;
                                 nPageOffset : Integer):integer;


CONST
  aFlatFactor : Array[0..31] of integer = (0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,8,8);
  aPageOffset : Array[0..31] of integer = (-1,0,1,2,-1,0,1,2,-1,0,1,2,-1,0,1,2,-1,0,1,2,-1,0,1,2,-1,0,1,2,-1,0,1,2);


Var
    bHalfWebInSection : Boolean; // true if we have passed a half-web signature
    nAccumulatedPages  : Integer; // Need total number of pages
    f,p : Integer;
    nAccumulatedPageNumber,nUniquePagesOnThisFlat : Integer;
    nLowestPageOnThisFlat,nPagesOnThisFlat,nHighestPageOnThisFlat : Integer;
    nSign,thisPageNumber : integer;

Begin
  bHalfWebInSection := false;
  nAccumulatedPages := 0;
  For f := 1 to pSection.nFlatsInSection do
  begin
    Inc(nAccumulatedPages,CountUniquePages(pSection.aFlats[f]));
  End;

  nAccumulatedPageNumber := 0;
  for f := 1 to pSection.nFlatsInSection do
  begin
    nUniquePagesOnThisFlat := CountUniquePages(pSection.aFlats[f]);
    nLowestPageOnThisFlat := 100000;
    nHighestPageOnThisFlat := 0;
    nPagesOnThisFlat := pSection.aFlats[f].nPagesPerSide;
    if (pSection.aFlats[f].bIsDualSided) then
      nPagesOnThisFlat := nPagesOnThisFlat * 2;

    for p :=1 to nPagesOnThisFlat do
    begin
      if ((pSection.aFlats[f].aPages[p] <> 0) and (pSection.aFlats[f].aPages[p] < nLowestPageOnThisFlat)) then
        nLowestPageOnThisFlat := pSection.aFlats[f].aPages[p];
      if ((pSection.aFlats[f].aPages[p] <> 0) and (pSection.aFlats[f].aPages[p] > nHighestPageOnThisFlat)) then
        nHighestPageOnThisFlat := pSection.aFlats[f].aPages[p];
    End;

    for p := 1 to nPagesOnThisFlat do
    begin
      thisPageNumber := pSection.aFlats[f].aPages[p];
      if (thisPageNumber <> 0) then
      Begin
        if (pSection.nBindingStyle = BINDING_SADDLESTITCHED)  then
        begin
          // Saddle stitched numbering
          // Determine sign (pos/neg) for flat offset adjust
          IF ( ( (thisPageNumber+1) DIV 2 ) mod 2 <> 0) then
            nSign := 1
          else
            nSign := -1;



          // Now for the magic..

          pSection.aFlats[f].aFinalPages[p] :=
            (4 * aFlatFactor[thisPageNumber-1] * nAccumulatedPages) DIV
              nUniquePagesOnThisFlat + nSign * f * 2 + aPageOffset[thisPageNumber-1];
        End
        else
        Begin
         // Perfect bound numbering
          pSection.aFlats[f].aFinalPages[p] := thisPageNumber + nAccumulatedPageNumber;
        End;
      End;

      //
      Inc(pSection.aFlats[f].aFinalPages[p],nPageOffset);

      if (nUniquePagesOnThisFlat < nPagesOnThisFlat) then
   			bHalfWebInSection := true;

    End;
    Inc(nAccumulatedPageNumber,nUniquePagesOnThisFlat);
  End;
  pSection.nPagesInSection := nAccumulatedPages;
  result := nAccumulatedPages;

end;





Function tform1.AdjustSectionHalfweb(sec             : Integer;
                                     Var pSection    : CSection;
                                     nPageNumber : Integer):integer;
Var
  f,p,i : Integer;
  nFlatToInsert : Integer;
	nPagesPerSide : Integer;
	nHighMatePageNumber : Integer;

	nMiddleLowMatePageNumber : Integer;
	nMiddleHighMatePageNumber : Integer;
	bIsDualSided : Boolean;
  nPagesOnThisFlat : Integer;

  pFlat1,pFlat2,pFlat : CFlat;


begin
	// Phase 1: Find flat at which we must insert half web
	//			Add to page numbers equal to or larger than the half web number(s)
	if (pSection.nFlatsInSection = 0) then
  begin
		result :=0;
    exit;
  end;
	nFlatToInsert := 0;
	nPagesPerSide := 0;
	nHighMatePageNumber := 0;
	nMiddleLowMatePageNumber := 0;
	nMiddleHighMatePageNumber := 0;
	bIsDualSided := TRUE;

	for f :=1 to pSection.nFlatsInSection do
  begin
		bIsDualSided := pSection.aFlats[f].bIsDualSided;
		nPagesPerSide := pSection.aFlats[f].nPagesPerSide;

		// Find
    IF bIsDualSided then
		  nPagesOnThisFlat := 2*nPagesPerSide
    else
      nPagesOnThisFlat := nPagesPerSide;

		for p :=1 to nPagesOnThisFlat do
    begin
      if pSection.aFlats[f].aFinalPages[p] = nPageNumber then
      begin
				if (nPageNumber < pSection.nPagesInSection DIV 2) then
					nFlatToInsert := f
				else
					nFlatToInsert := f+1;
			end;

			if (nPagesPerSide = 8) then
      begin
				// hw=3
				// 16-3+1=14
				nHighMatePageNumber := pSection.nPagesInSection-nPageNumber+1;
				if (pSection.aFlats[f].aFinalPages[p] > nHighMatePageNumber) then
        begin
					Inc(pSection.aFlats[f].aFinalPages[p],2);
				end;
				// 16/2+3-1=11
				nMiddleHighMatePageNumber := (pSection.nPagesInSection div 2)+nPageNumber-1;
				if (pSection.aFlats[f].aFinalPages[p] > nMiddleHighMatePageNumber) then
        begin
					Inc(pSection.aFlats[f].aFinalPages[p],2);
				end;

				// 16/2-3+1=6
				nMiddleLowMatePageNumber := (pSection.nPagesInSection div 2)-nPageNumber+1;
				if (pSection.aFlats[f].aFinalPages[p] > nMiddleLowMatePageNumber) then
        begin
					Inc(pSection.aFlats[f].aFinalPages[p],2);
				end;
			end;

			if (nPagesPerSide = 4) then
      begin
				nHighMatePageNumber := pSection.nPagesInSection-nPageNumber+1;
				if (pSection.aFlats[f].aFinalPages[p] > nHighMatePageNumber) then
        begin
					Inc(pSection.aFlats[f].aFinalPages[p],2);
				end;
			end;
			if (pSection.aFlats[f].aFinalPages[p] >= nPageNumber) then
      begin
				inc(pSection.aFlats[f].aFinalPages[p],2);
			end;

			//pSection.aFlats[f].aFinalPageNames[p].Format("%s%d%s", g_sSectionPrefixSection[sec],  pSection.aFlats[f].aFinalPages[p],g_sSectionPostfixSection[sec]);

		end;
	end;
	if (nFlatToInsert = 0) then
  begin
		result := 0;
    exit;
  end;

	if (nFlatToInsert = 1) and (pSection.nFlatsInSection > 1) then
		nFlatToInsert := 2;

	// Phase 2: Insert flat at position found
	//      1           2           3
	// (8-1  2-7)  (6-3  4-5)				BEFORE
	// (10-1 2-9)  (0-3  4-0)  (8-5  6-7)	AFTER

	for f := pSection.nFlatsInSection to nFlatToInsert do
  begin
		pFlat1 := pSection.aFlats[f];
		pFlat2 := pSection.aFlats[f+1];
		pFlat2.bIsDualSided := pFlat1.bIsDualSided;
		pFlat2.nPagesPerSide := pFlat1.nPagesPerSide;
    IF pFlat2.bIsDualSided then
      nPagesOnThisFlat := 2*pFlat2.nPagesPerSide
    else
		 nPagesOnThisFlat :=  pFlat2.nPagesPerSide;

		for p :=1 to nPagesOnThisFlat do
    begin
			pFlat2.aPages[p] := pFlat1.aPages[p];
			pFlat2.aFinalPages[p] := pFlat1.aFinalPages[p];
		end;
	end;

	// Phase 3: Insert half web page numbers
	pFlat := pSection.aFlats[nFlatToInsert];
	pFlat.bIsDualSided := bIsDualSided;
	pFlat.nPagesPerSide := nPagesPerSide;
	Inc(pSection.nFlatsInSection);
	//pSection.nPagesInSection+=pFlat.bIsDualSided  ? 2*pFlat.nPagesPerSide : pFlat.nPagesPerSide;
	Inc(pSection.nPagesInSection,pFlat.nPagesPerSide);

	// Insert the half web flat
	Case nPagesPerSide of
    2: Begin
         // front side
         for i := 1  to nPagesPerSide do
         begin
           if m_TemplateList[m_templateIdx].m_pagenumbersfronthalfweb[i-1] > 0 then
             pFlat.aFinalPages[i] := m_TemplateList[m_templateIdx].m_pagenumbersfronthalfweb[i-1]+nPageNumber-1
           else
             pFlat.aFinalPages[i] := 0;
         end;
         // back side
         for i := 1  to nPagesPerSide do
         begin
           if m_TemplateList[m_templateIdx].m_pagenumbersbackhalfweb[i-1] > 0 then
             pFlat.aFinalPages[i+nPagesPerSide] := m_TemplateList[m_templateIdx].m_pagenumbersbackhalfweb[i-1]+nPageNumber-1
           else
             pFlat.aFinalPages[i+nPagesPerSide] := 0;
         end;
       end;
	3: begin
     end;
	4: Begin
		   // front side
       for i :=1 to nPagesPerSide do
       begin
         if (m_TemplateList[m_templateIdx].m_pagenumbersfronthalfweb[i-1] = 0) then
           pFlat.aFinalPages[i] := 0
         else
         Begin
           IF m_TemplateList[m_templateIdx].m_pagenumbersfronthalfweb[i-1] > (nPagesPerSide div 2) then
             pFlat.aFinalPages[i] := m_TemplateList[m_templateIdx].m_pagenumbersfronthalfweb[i-1]+nHighMatePageNumber
           Else
             pFlat.aFinalPages[i] := m_TemplateList[m_templateIdx].m_pagenumbersfronthalfweb[i-1]+nPageNumber-1;
         End;
       end;

       // back side
       for i :=1 to nPagesPerSide do
       begin
         if (m_TemplateList[m_templateIdx].m_pagenumbersbackhalfweb[i-1] = 0) then
           pFlat.aFinalPages[i+nPagesPerSide] := 0
         else
         Begin
           IF m_TemplateList[m_templateIdx].m_pagenumbersbackhalfweb[i-1] > nPagesPerSide DIV 2 then
             pFlat.aFinalPages[i+nPagesPerSide] := m_TemplateList[m_templateIdx].m_pagenumbersbackhalfweb[i-1]+nHighMatePageNumber
           Else
             pFlat.aFinalPages[i+nPagesPerSide] := m_TemplateList[m_templateIdx].m_pagenumbersbackhalfweb[i-1]+nPageNumber-1;
         End;
       end;
		 end;
	6: Begin
     end;

  8: Begin
       (*
       // front side
       for i :=1 to nPagesPerSide do
       begin
         if (m_TemplateList[m_templateIdx].m_pagenumbersfronthalfweb[i-1] = 0) then
           pFlat.aFinalPages[i] := 0
         else
         begin
           if (pFlat.aFinalPages[i] = m_TemplateList[m_templateIdx].m_pagenumbersfronthalfweb[i-1] > nPagesPerSide-nPagesPerSide/4)
             pFlat.aFinalPages[i] = m_TemplateList[m_templateIdx].m_pagenumbersfronthalfweb[i-1]+nHighMatePageNumber;

            else if (pFlat.aFinalPages[i] == m_TemplateList[m_templateIdx].m_pagenumbersfronthalfweb[i-1] <= nPagesPerSide-nPagesPerSide/4 &&
                  pFlat.aFinalPages[i] == m_TemplateList[m_templateIdx].m_pagenumbersfronthalfweb[i-1] > nPagesPerSide/2)
             pFlat.aFinalPages[i] = m_TemplateList[m_templateIdx].m_pagenumbersfronthalfweb[i-1]+nMiddleHighMatePageNumber;
            else if (pFlat.aFinalPages[i] == m_TemplateList[m_templateIdx].m_pagenumbersfronthalfweb[i-1] <= nPagesPerSide/2 &&
                  pFlat.aFinalPages[i] == m_TemplateList[m_templateIdx].m_pagenumbersfronthalfweb[i-1] > nPagesPerSide/4)
             pFlat.aFinalPages[i] = m_TemplateList[m_templateIdx].m_pagenumbersfronthalfweb[i-1]+nMiddleLowMatePageNumber;
           else
             pFlat.aFinalPages[i] = m_TemplateList[m_templateIdx].m_pagenumbersfronthalfweb[i-1]+nPageNumber-1;
         end;
        end;
       // back side
       for i :=1 to nPagesPerSide do begin
         if (m_TemplateList[m_templateIdx].m_pagenumbersbackhalfweb[i-1] == 0)
           pFlat.aFinalPages[i+nPagesPerSide] = 0;
         else begin
           if (pFlat.aFinalPages[i] == m_TemplateList[m_templateIdx].m_pagenumbersbackhalfweb[i-1] > nPagesPerSide-nPagesPerSide/4) // x> 6
             pFlat.aFinalPages[i+nPagesPerSide] = m_TemplateList[m_templateIdx].m_pagenumbersbackhalfweb[i-1]+nHighMatePageNumber-nPagesPerSide;
            else if (pFlat.aFinalPages[i] == m_TemplateList[m_templateIdx].m_pagenumbersbackhalfweb[i-1] <= nPagesPerSide-nPagesPerSide/4 &&
                  pFlat.aFinalPages[i] == m_TemplateList[m_templateIdx].m_pagenumbersbackhalfweb[i-1] > nPagesPerSide/2) // 6 <= x < 4
             pFlat.aFinalPages[i+nPagesPerSide] = m_TemplateList[m_templateIdx].m_pagenumbersbackhalfweb[i-1]+nMiddleHighMatePageNumber-nPagesPerSide/2;
            else if (pFlat.aFinalPages[i] == m_TemplateList[m_templateIdx].m_pagenumbersbackhalfweb[i-1] <= nPagesPerSide/2 &&// 4 <= x < 2
                  pFlat.aFinalPages[i] == m_TemplateList[m_templateIdx].m_pagenumbersbackhalfweb[i-1] > nPagesPerSide/4)
             pFlat.aFinalPages[i+nPagesPerSide] = m_TemplateList[m_templateIdx].m_pagenumbersbackhalfweb[i-1]+nMiddleLowMatePageNumber-nPagesPerSide/2;
           else
             pFlat.aFinalPages[i+nPagesPerSide] = m_TemplateList[m_templateIdx].m_pagenumbersbackhalfweb[i-1]+nPageNumber-1;
         end;
        end;

       break;
     *)
   End;
	end;

	result := nPagesPerSide;
end;


Function tform1.Calculate:boolean;
Var
  Adjval,p,nPagesOnThisFlat,nMax,f,i,nPageOffset : Integer;

  Pagesonflat : Integer;
begin
	if (g_nSections = 0) then
  begin
		result := FALSE;
    exit;
  End;

	//UpdateData(TRUE);

	nMax := 0;
	for i :=0 to g_nSections do
  Begin
		if (g_nInitialPagesInSection[i] > nMax) then
			nMax := g_nInitialPagesInSection[i];
  End;

  m_pProduction.nSectionsInProduction := g_nSections; //antal sektioner
  m_pProduction.nMaxFlatsPerSection := nMax+16;
  m_pProduction.nGeneralPageOffset := 0;
  m_pProduction.m_bIsConsecutiveNumbering := 1;

  (*
  // Transfer values from user interface to structures
  if (GUItoStructures() == FALSE) then
  Begin
		result := FALSE;
    exit;
  End;
  *)

  // Calculate page numbers for sections individually
  m_pProduction.nPagesInProduction := 0;
	nPageOffset := 0;
	for i := 1 to m_pProduction.nSectionsInProduction DO
  begin
		Inc(m_pProduction.nPagesInProduction,CalculateSection(i, m_pProduction.aSections[i], nPageOffset));

		if (m_pProduction.aSections[i].nHalfWebPage > 0) and (m_pProduction.nPagesInProduction > 0) then
    begin
      Adjval := AdjustSectionHalfweb(i, m_pProduction.aSections[i],m_pProduction.aSections[i].nHalfWebPage - m_pProduction.aSections[i].nStartingPageNumber +1);
			Inc(m_pProduction.nPagesInProduction,Adjval);

			//g_nPagesInSection[i-1] = m_pProduction->aSections[i]->nPagesInSection;


		//if (m_pProduction->m_bIsConsecutiveNumbering == FALSE)
		//	nPageOffset += m_pProduction->aSections[i]->nPagesInSection + m_pProduction->aSections[i]->nStartingPageNumber - 1;


		// Save page numbering as is internal in sections
    End;

		for  f := 1 to m_pProduction.aSections[i].nFlatsInSection do
    begin
			nPagesOnThisFlat := m_pProduction.aSections[i].aFlats[f].nPagesPerSide;
			if (m_pProduction.aSections[i].aFlats[f].bIsDualSided) then
				nPagesOnThisFlat := nPagesOnThisFlat * 2;

			for p := 1 to nPagesOnThisFlat do
      begin
				g_nFinalPageNumbersInternal[i-1][f-1][p-1] := m_pProduction.aSections[i].aFlats[f].aFinalPages[p];
				g_nFinalPageNamesInternal[i-1][f-1][p-1] := m_pProduction.aSections[i].aFlats[f].aFinalPageNames[p];
			end;
		end;
	end;
  result := TRUE;
end;


end.

