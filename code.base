var
  BtnCekilisYap:TClProButton;
  MyWinForm,MyMobileForm:TCLForm;
  MyWinMQTT,MyMobileMQTT : TclMQTT;
  LblMobileDisplay,LblWinDisplay,LblMobileQuestion,LblWinCountDown : TclLabel;
  BtnCevapla:TCLButton;
  EdtCevap:TCLPRoEdit;
  CekilisTimer,CountDownTimer,CountDownTimerMobile:TCLTimer;
  count,second:integer;
  QMemList,QryQuestion:TclJSonQuery;
  dogruCvp:string;
  MyDevice:TclDeviceManager;
  selectedMember:string;
  winOnBtn,winOffBtn : TclButton;
  LogMemo : TclMemo;
  GetTimer: TClTimer;
  ACommand:string;
  OnAndOffControl : Boolean;
  PlayerList:TclStringList;
  
  varMiControl : Boolean;
  
  //Win Dizayn Tanımlamaları
  PnlTitleAndOnOff,PnlOnOffControl,PnlBalloon,PnlCekilis,PnlTimer : TclProPanel;
  BtnOnn, BtnOff, BtnStart,BtnTotalTimer,BtnPlayerTimer : TclProButton;
  LblCekilisPlayerName : TClProLabel;
  ImgTitle,ImgBalloon : TclProImage;
  
  
  //Mobil için Tanımlamalar
  LblExplanation : TClProLabel;
  ImgMobileTitle,ImgMobileBalloon : TclProImage;
  
  //soru kısmı
  PnlForm,PnlTopImg,PnlQuestion : TclProPanel;
  ImgQuestionBalloons : TclProImage;
  BtnQuestionReply,BtnQuestionPlayerTimer : TclProButton;
  LblQuestionTitle,LblQuestion : TClProLabel;
  EdtReply : TClProEdit;
  winUserGUID : String;
  
  function GetQuestion(AData:integer):string;
  begin
    QryQuestion := TCLJSONQuery.Create(nil);
    try
      try
        QryQuestion := Clomosy.ClDataSetFromJSON('[{"id":1,"soru":"3+5","cevap":8},begin"id":2,"soru":"10-2","cevap":8},{"id":3,"soru":"6*2","cevap":12},{"id":4,"soru":"8/2","cevap":4},{"id":5,"soru":"7+5","cevap":12},{"id":6,"soru":"20-10","cevap":10},{"id":7,"soru":"4*4","cevap":16},{"id":8,"soru":"21/3","cevap":7},{"id":9,"soru":"0+12","cevap":12},{"id":10,"soru":"10+3","cevap":13},{"id":11,"soru":"7-4","cevap":3},{"id":12,"soru":"9*2","cevap":18},{"id":13,"soru":"18/6","cevap":3},{"id":14,"soru":"5+8","cevap":13},{"id":15,"soru":"15-5","cevap":10},{"id":16,"soru":"6*3","cevap":18},{"id":17,"soru":"24/8","cevap":3},{"id":18,"soru":"4+7","cevap":11},{"id":19,"soru":"13-6","cevap":7},{"id":20,"soru":"3*7","cevap":21},{"id":21,"soru":"21/7","cevap":3},{"id":22,"soru":"9+4","cevap":13},{"id":23,"soru":"18-8","cevap":10},{"id":24,"soru":"5*5","cevap":25},{"id":25,"soru":"20/4","cevap":5},{"id":26,"soru":"2+6","cevap":8},{"id":27,"soru":"12-4","cevap":8},{"id":28,"soru":"7*2","cevap":14},{"id":29,"soru":"10/2","cevap":5},{"id":30,"soru":"8+4","cevap":12},{"id":31,"soru":"25-10","cevap":15},{"id":32,"soru":"5*3","cevap":15},{"id":33,"soru":"30/6","cevap":5},{"id":34,"soru":"1+9","cevap":10},{"id":35,"soru":"12+4","cevap":16},{"id":36,"soru":"9-3","cevap":6},{"id":37,"soru":"8*3","cevap":24},{"id":38,"soru":"28/7","cevap":4},{"id":39,"soru":"6+6","cevap":12},{"id":40,"soru":"15+2","cevap":17},{"id":41,"soru":"11-7","cevap":4},{"id":42,"soru":"7*5","cevap":35},{"id":43,"soru":"35/5","cevap":7},{"id":44,"soru":"4+6","cevap":10},{"id":45,"soru":"16-7","cevap":9},{"id":46,"soru":"3*8","cevap":24},{"id":47,"soru":"27/9","cevap":3},{"id":48,"soru":"5+9","cevap":14},{"id":49,"soru":"14-4","cevap":10},{"id":50,"soru":"4*6","cevap":24},{"id":51,"soru":"10+10","cevap":20},{"id":52,"soru":"15-5","cevap":10},{"id":53,"soru":"8*4","cevap":32},{"id":54,"soru":"32/4","cevap":8},{"id":55,"soru":"9+11","cevap":20},{"id":56,"soru":"25-15","cevap":10},{"id":57,"soru":"7*5","cevap":35},{"id":58,"soru":"36/6","cevap":6},{"id":59,"soru":"12+8","cevap":20},{"id":60,"soru":"14+7","cevap":21},{"id":61,"soru":"28-14","cevap":14},{"id":62,"soru":"9*3","cevap":27},{"id":63,"soru":"27/9","cevap":3},{"id":64,"soru":"7+8","cevap":15},{"id":65,"soru":"30-10","cevap":20},{"id":66,"soru":"5*5","cevap":25},{"id":67,"soru":"45/9","cevap":5},{"id":68,"soru":"11+9","cevap":20},{"id":69,"soru":"16+5","cevap":21},{"id":70,"soru":"21-1","cevap":20},{"id":71,"soru":"6*6","cevap":36},{"id":72,"soru":"48/8","cevap":6},{"id":73,"soru":"10+12","cevap":22},{"id":74,"soru":"24+7","cevap":31},{"id":75,"soru":"31-9","cevap":22},{"id":76,"soru":"9*4","cevap":36},{"id":77,"soru":"36/6","cevap":6},{"id":78,"soru":"14+9","cevap":23},{"id":79,"soru":"25-2","cevap":23},{"id":80,"soru":"4*7","cevap":28},{"id":81,"soru":"49/7","cevap":7},{"id":82,"soru":"13+11","cevap":24},{"id":83,"soru":"26+5","cevap":31},{"id":84,"soru":"31-6","cevap":25},{"id":85,"soru":"6*7","cevap":42},{"id":86,"soru":"56/8","cevap":7},{"id":87,"soru":"15+11","cevap":26},{"id":88,"soru":"27+6","cevap":33},{"id":89,"soru":"33-7","cevap":26},{"id":90,"soru":"5*8","cevap":40},{"id":91,"soru":"40/5","cevap":8},{"id":92,"soru":"17+14","cevap":31},{"id":93,"soru":"35+8","cevap":43},{"id":94,"soru":"43-12","cevap":31},{"id":95,"soru":"7*7","cevap":49},{"id":96,"soru":"63/9","cevap":7},{"id":97,"soru":"18+15","cevap":33},{"id":98,"soru":"33+12","cevap":45},{"id":99,"soru":"45-10","cevap":35},{"id":100,"soru":"8*6","cevap":48},{"id":101,"soru":"48/6","cevap":8},{"id":102,"soru":"20+16","cevap":36},{"id":103,"soru":"36+10","cevap":46},{"id":104,"soru":"46-6","cevap":40},{"id":105,"soru":"9*5","cevap":45},{"id":106,"soru":"54/9","cevap":6},{"id":107,"soru":"22+19","cevap":41},{"id":108,"soru":"38+9","cevap":47},{"id":109,"soru":"47-6","cevap":41},{"id":110,"soru":"10*5","cevap":50},{"id":111,"soru":"60/10","cevap":6},{"id":112,"soru":"25+18","cevap":43},{"id":113,"soru":"43+10","cevap":53},{"id":114,"soru":"53-10","cevap":43},{"id":115,"soru":"11*5","cevap":55},{"id":116,"soru":"55/11","cevap":5},{"id":117,"soru":"30+20","cevap":50},{"id":118,"soru":"50+5","cevap":55},{"id":119,"soru":"55-5","cevap":50},{"id":120,"soru":"12*5","cevap":60},{"id":121,"soru":"60/12","cevap":5},{"id":122,"soru":"35+20","cevap":55},{"id":123,"soru":"55+6","cevap":61},{"id":124,"soru":"61-6","cevap":55},{"id":125,"soru":"13*5","cevap":65},{"id":126,"soru":"65/13","cevap":5},{"id":127,"soru":"40+20","cevap":60},{"id":128,"soru":"60+7","cevap":67},{"id":129,"soru":"67-7","cevap":60},{"id":130,"soru":"14*5","cevap":70},{"id":131,"soru":"70/14","cevap":5},{"id":132,"soru":"45+20","cevap":65},{"id":133,"soru":"65+8","cevap":73},{"id":134,"soru":"73-8","cevap":65},{"id":135,"soru":"15*5","cevap":75},{"id":136,"soru":"75/15","cevap":5},{"id":137,"soru":"50+20","cevap":70},{"id":138,"soru":"70+9","cevap":79},{"id":139,"soru":"79-9","cevap":70},{"id":140,"soru":"16*5","cevap":80},{"id":141,"soru":"80/16","cevap":5},{"id":142,"soru":"55+20","cevap":75},{"id":143,"soru":"75+10","cevap":85},{"id":144,"soru":"85-10","cevap":75},{"id":145,"soru":"17*5","cevap":85},{"id":146,"soru":"85/17","cevap":5},{"id":147,"soru":"60+20","cevap":80},{"id":148,"soru":"80+11","cevap":91},{"id":149,"soru":"91-11","cevap":80},{"id":150,"soru":"18*5","cevap":90}]');
        with QryQuestion do 
        begin
          Filtered := False;
          Filter := 'id = '+IntToStr(AData);
          Filtered := True;
          Result := FieldByName('soru').AsString+'|'+FieldByName('cevap').AsString;
        end;
      except 
      
        ShowMessage('Exception Class: '+LastExceptionClassName+' Exception Message: '+LastExceptionMessage);
      end;
    finally 
    

    end;
  end;
  procedure SetMobileState(AState:Boolean);
  begin
    PnlForm.Visible := AState;
    if not AState then
    begin
      if (not MyMobileMQTT.Connected) then
        MyMobileMQTT.Connect;      
      MyMobileMQTT.Send('MOBILE'+'|'+'cekilis');
    end;
  end;
  procedure BtnCekilisYapOnClick;
  begin
    second := 20;
    CountDownTimer.Enabled  := False;
    MyWinMQTT.Send('WIN|True');
    QMemList := Clomosy.DBCloudQueryWith(ftMembers,'','ISNULL(PMembers.Rec_Deleted,0)=0 ORDER BY NEWID()');//Projeye dahil üyeleri çeker. ATILMIŞLAR GELMEZ
    QMemList.Filter := 'Member_GUID <> '+QuotedStr(winUserGUID);
    QMemList.Filtered := True;
    CekilisTimer.Enabled := True;
    LblCekilisPlayerName.Caption := '';
  end;

  procedure timerShow;
  begin
    if ACommand <> '' then
    begin
      MyWinMQTT.Send(ACommand);
    end;
  end;
  
  procedure WinMQTTMessageHandler(xMes:string);
  begin
    if clGetStringTo(xMes,'|') = 'MOBILE' then
    begin
      if clGetStringAfter(xMes,'|') = 'cekilis' then
      begin
        ACommand := 'BOFF';
        timerShow;
        GetTimer.Enabled := True;
        second := 20;
        BtnPlayerTimer.Visible := True;
        CountDownTimer.Enabled  := False;
        BtnCekilisYapOnClick;
      end;
    end else if clGetStringTo(xMes,'|') = 'IOT' then
    begin
      if clGetStringAfter(xMes,'|') = 'OK' then
      begin
        ACommand := '';
        GetTimer.Enabled := False;
      end;
    end;
  end;

  procedure MyWinMQTTPublishReceived;
  var
    msj:string;
  begin
    if (MyWinMQTT.ReceivedAlright) then
    begin 
      if (Not Clomosy.PlatformIsMobile) then
      begin
        msj := clGetStringTo(MyWinMQTT.ReceivedMessage,'|');
        if ((msj = 'MOBILE') or (msj = 'IOT')) then
        begin
          WinMQTTMessageHandler(MyWinMQTT.ReceivedMessage);
        end;
      end;
    end;
  end;

  procedure MobileMQTTMessageHandler(xMsj:String);
  var
    soruCvp,content:string;
  begin
    if OnAndOffControl then
    begin
        content := clGetStringAfter(xMsj,'|');
        if clGetStringTo(content,':') = Clomosy.AppUserGUID then
        begin
          if (clGetStringAfter(content,':') = 'uyesecim') then
          begin
            SetMobileState(True);
            soruCvp := GetQuestion(clMath.GenerateRandom(1,150));
            LblExplanation.Caption := 'Sen Çıktın!';
            PnlForm.Visible := True;
            ImgMobileBalloon.Visible := False;
            ImgMobileTitle.Visible := False;
            MyDevice.Vibrate(500);
            LblQuestion.Caption := 'Soru:'+#13+''
            LblQuestion.Caption := LblQuestion.Caption + clGetStringTo(soruCvp,'|');   //SORU
            dogruCvp := clGetStringAfter(soruCvp,'|');                 //CVP
          end else if (clGetStringAfter(content,':') = 'suredoldu') then
          begin
            ImgMobileBalloon.Visible := True;
            ImgMobileTitle.Visible := True;
            clComponent.SetupComponent(ImgMobileBalloon,'{"ImgUrl":"https://clomosy.com/demos/timer_baloons2.png"}');
            LblExplanation.Caption := 'SURENIZ DOLDU!!!';
            SetMobileState(False);
          end;
          end else
          begin
              PnlForm.Visible := false;
              ImgMobileBalloon.Visible := True;
              ImgMobileTitle.Visible := True;
              LblExplanation.Caption := 'Bekleniyor...';
              //SetMobileState(False);
          end;
    end else
    begin
      PnlForm.Visible := false;
      ImgMobileBalloon.Visible := True;
      ImgMobileTitle.Visible := True;
       LblExplanation.Caption := 'Bekleniyor...';
    end;
  end;
  
  procedure MyMobileMQTTPublishReceived;
  var
    msj:string;
  begin
    msj:='';
    if (MyMobileMQTT.ReceivedAlright) then
    begin
      if (Clomosy.PlatformIsMobile) then
      begin
        msj := MyMobileMQTT.ReceivedMessage;
          if clGetStringTo(msj,'|') = 'WIN' then
          begin
            if clGetStringAfter(msj,'|') = 'True' then
            begin
              OnAndOffControl := True;
            end else if clGetStringAfter(msj,'|') = 'False' then
            begin
              OnAndOffControl := False;
            end;
            MobileMQTTMessageHandler(msj);
          end;
      end;
    end;
  end;
  
  procedure CekilisTimerOnTimer;
  var
  i : Integer;
  begin
    LblCekilisPlayerName.Caption := QMemList.FieldByName('Member_Name').AsString;
    Clomosy.ProcessMessages;
    if(count=15) then
    begin    //GUID
      count := 0;
      if PlayerList.Count = QMemList.RecordCount then
      begin
        PlayerList.Free;
        PlayerList := Clomosy.StringListNew;
      end;
      
      for i := 0 to PlayerList.Count - 1 do
      begin
        if QMemList.FieldByName('Member_GUID').AsString = Clomosy.StringListItemString(PlayerList,i) then
        begin
          varMiControl := True;
          break;
        end else
        begin
          varMiControl := False;
        end;
      end;
      
      if varMiControl then
      begin
        CekilisTimerOnTimer;
      end else
      begin
        CekilisTimer.Enabled    := False;
        selectedMember := QMemList.FieldByName('Member_GUID').AsString;
        
        PlayerList.Add(selectedMember);
        
        
        
        MyWinMQTT.Send('WIN'+'|'+selectedMember+':'+'uyesecim');
        BtnPlayerTimer.Visible := True;
        CountDownTimer.Enabled  := True;
        ACommand := 'BON';
        timerShow;
        GetTimer.Enabled := True;
        exit;
      end;
    end;
    QMemList.Next;
    if (QMemList.EOF) then
    begin
      QMemList.First;
    end;
    Inc(count);
  end;
  
  procedure CountDownTimerOnTimer
  begin
    BtnPlayerTimer.Caption := IntToStr(second);
    if second = 0 then
    begin    //Cekilis Yap Tekrardan
      MyWinMQTT.Send('WIN'+'|'+selectedMember+':'+'suredoldu');
      //LblMobileDisplay.Caption := 'SURENIZ DOLDU!!!';
      BtnPlayerTimer.Visible := False;
      CountDownTimer.Enabled := False;
      ACommand := 'BOFF';
      timerShow;
      GetTimer.Enabled := True;
      BtnPlayerTimer.Visible := True;
      BtnCekilisYapOnClick;
    end;
    Dec(second);
  end;
  
  procedure BtnCevaplaOnClick;
  begin
    if dogruCvp = EdtReply.Text then
    begin
      LblExplanation.Caption := 'DOGRU CEVAP!!!';
      ImgMobileBalloon.Visible := True;
      SetMobileState(False);
    end else
    begin
      LblExplanation.Caption := 'YANLIŞ CEVAP!!!';
    end;
    EdtReply.Text := '';
  end;
  
  procedure winOnnBtnOnClick;
  begin
    //ACommand := 'BON'
    //timerShow;
    MyWinMQTT.Send('WIN|True');
    //MobileMQTTMessageHandler('');
    GetTimer.Enabled := True;
    BtnCekilisYapOnClick;
    
   // MyIotMqtt.Send('BON');
  end;
  procedure winOffBtnOnClick;
  begin
    //OnAndOffControl := false;
    //MobileMQTTMessageHandler('');
    MyWinMQTT.Send('WIN|False');
    ACommand := 'BOFF'
    timerShow;
    //GetTimer.Enabled := True;
    CekilisTimer.Enabled := False;
    CountDownTimer.Enabled := False;
    
  //  MyIotMqtt.Send('BOFF');
  end;

  procedure MyWinMQTTStatusChanged;
  begin
     if not MyWinMQTT.Connected then
     begin 
      MyWinMQTT.Connect;
   end;
  end;
  procedure MyMobileMQTTStatusChanged;
  begin
     if not MyMobileMQTT.Connected then
     begin 
      MyMobileMQTT.Connect;
   end;
  end;
  
  
begin //MAIN
  OnAndOffControl := True;
  PlayerList := Clomosy.StringListNew;
  varMiControl := False;
  if (not Clomosy.PlatformIsMobile) then
  begin //  Win Tarafi

    MyWinForm := TCLForm.Create(Self);
    MyWinForm.SetFormBGImage('https://clomosy.com/demos/bgmobil.png');
    
    winUserGUID := Clomosy.AppUserGUID;
    count := 0;
    second := 20;

    GetTimer := MyWinForm.AddNewTimer(MyWinForm,'GetTimer',500); // the action is triggered every 1 second.
    MyWinForm.AddNewEvent(GetTimer,tbeOnTimer,'timerShow'); // Calls timerShow Procedure
    GetTimer.Enabled := False;



    //PANEL => BAŞLIK VE ONN OFF BUTONU
    PnlTitleAndOnOff:=MyWinForm.AddNewProPanel(MyWinForm,'PnlTitleAndOnOff');
    clComponent.SetupComponent(PnlTitleAndOnOff,'{"Align" : "MostTop","MarginTop":10,
    "Height":120}');
    
    //PANEL => ON VE OFF BUTONLARI  
    PnlOnOffControl:=MyWinForm.AddNewProPanel(PnlTitleAndOnOff,'PnlOnOffControl');
    clComponent.SetupComponent(PnlOnOffControl,'{"Align" : "Left","MarginTop":5,"MarginBottom":5,"MarginLeft":5,
    "Width" :70}');
    
    BtnOnn := MyWinForm.AddNewProButton(PnlOnOffControl,'BtnOnn','ON');
    clComponent.SetupComponent(BtnOnn,'{"Align" : "MostTop","MarginTop":5,"MarginLeft":5,"MarginRight":5,
    "Height":50,"RoundHeight":10, "RoundWidth":10,"BorderColor":"1c92f4","BorderWidth":3,
    "BackgroundColor":"#ffffff","TextColor":"1c92f4","TextSize":15,"TextBold":"yes"}');
    BtnOnn.clTagInt := 0;
    MyWinForm.AddNewEvent(BtnOnn,tbeOnClick,'winOnnBtnOnClick');
    
    BtnOff := MyWinForm.AddNewProButton(PnlOnOffControl,'BtnOff','OFF');
    clComponent.SetupComponent(BtnOff,'{"Align" : "Top","MarginTop":5,"MarginLeft":5,"MarginRight":5,
    "Height":50,"RoundHeight":10, "RoundWidth":10,"BorderColor":"1c92f4","BorderWidth":3,
    "BackgroundColor":"#ffffff","TextColor":"1c92f4","TextSize":15,"TextBold":"yes"}');
    BtnOff.clTagInt := 0;
    MyWinForm.AddNewEvent(BtnOff,tbeOnClick,'winOffBtnOnClick');
    
    
    //BAŞLIK IMG
    ImgTitle := MyWinForm.AddNewProImage(PnlTitleAndOnOff,'ImgTitle');
    clComponent.SetupComponent(ImgTitle,'{"Align" : "Client","MarginTop":25,"MarginBottom":25,"MarginLeft":40,"MarginRight":40,
    "ImgUrl":"https://clomosy.com/demos/balonpatlatma.png", "ImgFit":"yes"}');
    
    //PANEL => BALON RESMİ
    PnlBalloon:=MyWinForm.AddNewProPanel(MyWinForm,'PnlBalloon');
    clComponent.SetupComponent(PnlBalloon,'{"Align" : "Top","MarginTop":5,
    "Height" :120}');
    
    ImgBalloon := MyWinForm.AddNewProImage(PnlBalloon,'ImgBalloon');
    clComponent.SetupComponent(ImgBalloon,'{"Align" : "Right","MarginRight":10,
    "ImgUrl":"https://clomosy.com/demos/balloon3.png", "ImgFit":"yes"}');
    
    //PANEL => ÇEKİLİŞ İSİM VE BUTONU
    PnlCekilis:=MyWinForm.AddNewProPanel(MyWinForm,'PnlCekilis');
    clComponent.SetupComponent(PnlCekilis,'{"Align" : "Top","MarginTop":5,
    "Height" :140}');
    
    LblCekilisPlayerName := MyWinForm.AddNewProLabel(PnlCekilis,'LblCekilisPlayerName','Oyuncu Bekleniyor');
    clComponent.SetupComponent(LblCekilisPlayerName,'{"Align" : "MostTop","Height":'+IntToStr(LblCekilisPlayerName.Height*2)+',"TextSize":35,"Margintop":10,
    "TextVerticalAlign":"center", "TextHorizontalAlign":"center","TextBold":"yes"}');
    
    BtnStart := MyWinForm.AddNewProButton(PnlCekilis,'BtnStart','BAŞLAT');
    clComponent.SetupComponent(BtnStart,'{"Align" : "Top","MarginTop":15,"MarginLeft":80,"MarginRight":80,
    "Height":50,"RoundHeight":20, "RoundWidth":20,"BackgroundColor":"#f42727",
    "TextColor":"#ffffff","TextSize":20,"TextBold":"yes"}');
     MyWinForm.AddNewEvent(BtnStart,tbeOnClick,'BtnCekilisYapOnClick');
    
    
    //PANEL => TİMER
    PnlTimer:=MyWinForm.AddNewProPanel(MyWinForm,'PnlTimer');
    clComponent.SetupComponent(PnlTimer,'{"Align" : "Top","MarginTop":5,
    "Height" :130}');
    
    BtnPlayerTimer := MyWinForm.AddNewProButton(PnlTimer,'BtnPlayerTimer','');
    clComponent.SetupComponent(BtnPlayerTimer,'{"Align" : "Left","MarginTop":15,"MarginLeft":5,
    "Width":200,"TextColor":"#ffffff","TextSize":20,"TextBold":"yes","ImgUrl":"https://clomosy.com/demos/time.png", "ImgFit":"yes"}');
    BtnPlayerTimer.Caption := 'Oyuncunun Süresi';
    //BtnPlayerTimer.Visible := False;
    
    BtnTotalTimer := MyWinForm.AddNewProButton(PnlTimer,'BtnTotalTimer','');
    clComponent.SetupComponent(BtnTotalTimer,'{"Align" : "Right","MarginTop":15,"MarginRight":5,
    "Width":200,"TextColor":"#ffffff","TextSize":18,"TextBold":"yes","ImgUrl":"https://clomosy.com/demos/time2.png", "ImgFit":"yes"}');
    BtnTotalTimer.Caption := 'Toplam Süre';
    
    
    CountDownTimer:= MyWinForm.AddNewTimer(MyWinForm,'CountDownTimer',1000);
    CountDownTimer.Enabled := false;
    MyWinForm.AddNewEvent(CountDownTimer,tbeOnTimer,'CountDownTimerOnTimer');
    
    
    
    CekilisTimer:= MyWinForm.AddNewTimer(MyWinForm,'CekilisTimer',200);
    CekilisTimer.Enabled := false;
    MyWinForm.AddNewEvent(CekilisTimer,tbeOnTimer,'CekilisTimerOnTimer');
    
    
    
    
    
    MyWinMQTT := MyWinForm.AddNewMQTTConnection(MyWinForm,'MyWinMQTT');
    MyWinForm.AddNewEvent(MyWinMQTT,tbeOnMQTTPublishReceived,'MyWinMQTTPublishReceived');
    MyWinForm.AddNewEvent(MyWinMQTT,tbeOnMQTTStatusChanged,'MyWinMQTTStatusChanged');
    MyWinMQTT.Channel := 'clomosy';//project guid + channel
    MyWinMQTT.Connect;
    MyWinForm.Run;
    
  end;
  else
  begin                               //  Mobile Tarafi
    MyMobileForm := TCLForm.Create(Self);
    MyMobileForm.SetFormBGImage('https://clomosy.com/demos/bgmobil.png');
    dogruCvp := '';
    MyDevice:=TclDeviceManager.Create; 
    
    
    ImgMobileTitle := MyMobileForm.AddNewProImage(MyMobileForm,'ImgMobileTitle');
    clComponent.SetupComponent(ImgMobileTitle,'{"Align" : "MostTop","MarginTop":20,"MarginLeft":20,"MarginRight":20,"Height":100,"ImgUrl":"https://clomosy.com/demos/balonpatlatma.png","ImgFit":"yes"}'); 
    
    
    ImgMobileBalloon := MyMobileForm.AddNewProImage(MyMobileForm,'ImgMobileBalloon');
    clComponent.SetupComponent(ImgMobileBalloon,'{"Align" : "Client","MarginBottom":10,"MarginTop":20,"MarginLeft":20,"MarginRight":20,"ImgUrl":"https://clomosy.com/demos/balloons.png","ImgFit":"yes"}');
    
    
    LblExplanation := MyMobileForm.AddNewProLabel(MyMobileForm,'LblExplanation','Bekleniyor...');
    clComponent.SetupComponent(LblExplanation,'{"Align" : "Bottom","Height":'+IntToStr(LblExplanation.Height*2)+',"TextSize":25,"MarginBottom":20,
    "TextVerticalAlign":"center", "TextHorizontalAlign":"center","TextBold":"yes"}');
    
    //SORU CEVAPLA ALANI
    //PANEL => FORM
    PnlForm:=MyMobileForm.AddNewProPanel(MyMobileForm,'PnlForm');
    clComponent.SetupComponent(PnlForm,'{"Align" : "Client"}');
    PnlForm.Visible := False;
    
    //PANEL :=> BALONLAR VE ZAMAN
    PnlTopImg:=MyMobileForm.AddNewProPanel(PnlForm,'PnlTopImg');
    clComponent.SetupComponent(PnlTopImg,'{"Align" : "MostTop","MarginTop":15,"Marginleft":15,"MarginRight":15,
    "Height":120}');
    
    ImgQuestionBalloons := MyMobileForm.AddNewProImage(PnlTopImg,'ImgQuestionBalloons');
    clComponent.SetupComponent(ImgQuestionBalloons,'{"Align" : "Center","Height":'+IntToStr(PnlTopImg.Height)+',"Width":'+IntToStr(PnlTopImg.Width)+',
    "ImgUrl":"https://clomosy.com/demos/balloon4.png","ImgFit":"yes"}');
    
    BtnQuestionPlayerTimer := MyMobileForm.AddNewProButton(PnlTopImg,'BtnQuestionPlayerTimer','');
    clComponent.SetupComponent(BtnQuestionPlayerTimer,'{"Align" : "Center","Height":'+IntToStr(PnlTopImg.Height/2)+',"Width":'+IntToStr(PnlTopImg.Width)+',
    "ImgUrl":"https://clomosy.com/demos/time3.png","ImgFit":"yes","TextColor":"#000000","TextSize":25,"TextBold":"yes"}');
    BtnQuestionPlayerTimer.Caption := '0';
    
    LblQuestionTitle := MyMobileForm.AddNewProLabel(PnlForm,'LblQuestionTitle','Sıra Sende!');
    clComponent.SetupComponent(LblQuestionTitle,'{"Align" : "Top","Height":'+IntToStr(LblQuestionTitle.Height*2)+',"TextSize":35,"Margintop":10,
    "TextVerticalAlign":"center", "TextHorizontalAlign":"center","TextColor":"#1c92f4","TextBold":"yes"}');
    
    //PANEL => SORU VE CEVAP KISMI
    PnlQuestion:=MyMobileForm.AddNewProPanel(PnlForm,'PnlQuestion');
    clComponent.SetupComponent(PnlQuestion,'{"Align" : "Client","MarginTop":15,"Marginleft":25,"MarginRight":25,"MarginBottom":35}');
    
    LblQuestion := MyMobileForm.AddNewProLabel(PnlQuestion,'LblQuestion','Soru:'+#13+'');
    clComponent.SetupComponent(LblQuestion,'{"Align" : "MostTop","Height":90,"TextSize":20,"MarginTop":15,"Marginleft":35,"MarginRight":35,
    "TextVerticalAlign":"center", "TextHorizontalAlign":"center","TextColor":"#f42727","TextBold":"yes","BorderColor":"#f42727","BorderWidth":3,"RoundHeight":20,"RoundWidth":20}');
    
    
    EdtReply := MyMobileForm.AddNewProEdit(PnlQuestion,'EdtReply','Cevap Yaz...');
    clComponent.SetupComponent(EdtReply,'{"Align" : "Top","Height":50,"TextSize":20,"MarginTop":15,"Marginleft":65,"MarginRight":65,
    "TextVerticalAlign":"center", "TextHorizontalAlign":"center","TextColor":"#f42727","TextBold":"yes","BorderColor":"#f42727",
    "BorderWidth":3,"RoundHeight":20,"RoundWidth":20}');
    EdtReply.clTypeOfField := taFloat;
    
    BtnQuestionReply := MyMobileForm.AddNewProButton(PnlQuestion,'BtnQuestionReply','cevapla');
    clComponent.SetupComponent(BtnQuestionReply,'{"Align" : "Top","Height":50,"TextSize":20,"MarginTop":15,"Marginleft":95,"MarginRight":95,
    "TextVerticalAlign":"center", "TextHorizontalAlign":"center","TextColor":"#ffffff","TextBold":"yes","backgroundcolor":"#1c92f4",
    "RoundHeight":20,"RoundWidth":20}');
    MyMobileForm.AddNewEvent(BtnQuestionReply,tbeOnClick,'BtnCevaplaOnClick');
    
    MyMobileMQTT := MyMobileForm.AddNewMQTTConnection(MyMobileForm,'MyMobileMQTT');
    MyMobileForm.AddNewEvent(MyMobileMQTT,tbeOnMQTTPublishReceived,'MyMobileMQTTPublishReceived');
    MyMobileForm.AddNewEvent(MyMobileMQTT,tbeOnMQTTStatusChanged,'MyMobileMQTTStatusChanged');
    MyMobileMQTT.Channel := 'clomosy';//project guid + channel
    MyMobileMQTT.Connect;
    
    //MyIotMqtt := MyMobileForm.AddNewMQTTConnection(MyMobileForm,'MyIotMqtt');
    //MyIotMqtt.Channel := 'clomosy';//project guid + channel
    //MyIotMqtt.Connect;

    MyMobileForm.Run;
    
  end;
end;
