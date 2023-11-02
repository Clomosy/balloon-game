var
  BtnCekilisYap:TClProButton;
  MyWinForm,MyMobileForm:TCLForm;
  MyWinMQTT,MyMobileMQTT : TclMQTT;
  LblMobileDisplay,LblWinDisplay,LblMobileQuestion,LblWinCountDown : TclLabel;
  BtnCevapla:TCLButton;
  EdtCevap:TCLPRoEdit;
  CekilisTimer,CountDownTimer:TCLTimer;
  count,second:integer;
  QMemList,QryQuestion:TclJSonQuery;
  dogruCvp:string;
  MyDevice:TclDeviceManager;
  selectedMember:string;
  winOnBtn,winOffBtn : TclButton;
  LogMemo : TclMemo;
  GetTimer: TClTimer;
  
  LoopState:Boolean;
  ACommand:string;
  
  
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
  
  function GetQuestion(AData:integer):string;
  {
    QryQuestion = TCLJSONQuery.Create(nil);
    try
      try
        QryQuestion = Clomosy.ClDataSetFromJSON('[{"id":1,"soru":"3+5","cevap":8},{"id":2,"soru":"10-2","cevap":8},{"id":3,"soru":"6*2","cevap":12},{"id":4,"soru":"8/2","cevap":4},{"id":5,"soru":"7+5","cevap":12},{"id":6,"soru":"20-10","cevap":10},{"id":7,"soru":"4*4","cevap":16},{"id":8,"soru":"21/3","cevap":7},{"id":9,"soru":"0+12","cevap":12},{"id":10,"soru":"10+3","cevap":13},{"id":11,"soru":"7-4","cevap":3},{"id":12,"soru":"9*2","cevap":18},{"id":13,"soru":"18/6","cevap":3},{"id":14,"soru":"5+8","cevap":13},{"id":15,"soru":"15-5","cevap":10},{"id":16,"soru":"6*3","cevap":18},{"id":17,"soru":"24/8","cevap":3},{"id":18,"soru":"4+7","cevap":11},{"id":19,"soru":"13-6","cevap":7},{"id":20,"soru":"3*7","cevap":21},{"id":21,"soru":"21/7","cevap":3},{"id":22,"soru":"9+4","cevap":13},{"id":23,"soru":"18-8","cevap":10},{"id":24,"soru":"5*5","cevap":25},{"id":25,"soru":"20/4","cevap":5},{"id":26,"soru":"2+6","cevap":8},{"id":27,"soru":"12-4","cevap":8},{"id":28,"soru":"7*2","cevap":14},{"id":29,"soru":"10/2","cevap":5},{"id":30,"soru":"8+4","cevap":12},{"id":31,"soru":"25-10","cevap":15},{"id":32,"soru":"5*3","cevap":15},{"id":33,"soru":"30/6","cevap":5},{"id":34,"soru":"1+9","cevap":10},{"id":35,"soru":"12+4","cevap":16},{"id":36,"soru":"9-3","cevap":6},{"id":37,"soru":"8*3","cevap":24},{"id":38,"soru":"28/7","cevap":4},{"id":39,"soru":"6+6","cevap":12},{"id":40,"soru":"15+2","cevap":17},{"id":41,"soru":"11-7","cevap":4},{"id":42,"soru":"7*5","cevap":35},{"id":43,"soru":"35/5","cevap":7},{"id":44,"soru":"4+6","cevap":10},{"id":45,"soru":"16-7","cevap":9},{"id":46,"soru":"3*8","cevap":24},{"id":47,"soru":"27/9","cevap":3},{"id":48,"soru":"5+9","cevap":14},{"id":49,"soru":"14-4","cevap":10},{"id":50,"soru":"4*6","cevap":24}]');
        with QryQuestion do {
          Filtered = False;
          Filter = 'id = '+IntToStr(AData);
          Filtered = True;
          Result = FieldByName('soru').AsString+'|'+FieldByName('cevap').AsString;
        }
      except{
        ShowMessage('Exception Class: '+LastExceptionClassName+' Exception Message: '+LastExceptionMessage);
      }
    finally{
    
    }
  }
  void SetMobileState(AState:Boolean);
  {
    PnlForm.Visible = AState;
    if not AState{
      if (not MyMobileMQTT.Connected)
        MyMobileMQTT.Connect;      
      MyMobileMQTT.Send('MOBILE'+'|'+'cekilis');
    }
  }
  void BtnCekilisYapOnClick;
  {
    second = 20;
    CountDownTimer.Enabled  = False;
    QMemList = Clomosy.DBCloudQueryWith(ftMembers,'','ISNULL(PMembers.Rec_Deleted,0)=0 ORDER BY NEWID()');//Projeye dahil üyeleri çeker. ATILMIŞLAR GELMEZ
    QMemList.Filtered = False;
    QMemList.Filter = 'Member_GUID <> '+QuotedStr('PMP86U93J9');
    QMemList.Filtered = True;
    CekilisTimer.Enabled = True;
    LblCekilisPlayerName.Caption = '';
  }

  void timerShow;
  {
    if ACommand <> '' 
    {
      MyWinMQTT.Send(ACommand);
    }
  }
  
  void WinMQTTMessageHandler(xMes:string);
  {
    if clGetStringTo(xMes,'|') == 'MOBILE' {
      if clGetStringAfter(xMes,'|') == 'cekilis' {
        ACommand = 'OFF1';
        timerShow;
        GetTimer.Enabled = True;
        second = 20;
        BtnPlayerTimer.Visible = True;
        CountDownTimer.Enabled  = False;
        BtnCekilisYapOnClick;
      }
    } else if clGetStringTo(xMes,'|') == 'IOT' {
      if clGetStringAfter(xMes,'|') == 'OK' {
        ACommand = '';
        GetTimer.Enabled = False;
      }
    }
  }

  void MyWinMQTTPublishReceived;
  var
    msj:string;
  {
    if (MyWinMQTT.ReceivedAlright){
      if (Not Clomosy.PlatformIsMobile) {
        msj = clGetStringTo(MyWinMQTT.ReceivedMessage,'|');
        if ((msj == 'MOBILE') || (msj == 'IOT'))
        {
          WinMQTTMessageHandler(MyWinMQTT.ReceivedMessage);
        }
      }
    }
  }

  void MobileMQTTMessageHandler(xMsj:String);
  var
    soruCvp,content:string;
  {
    content = clGetStringAfter(xMsj,'|');
    if clGetStringTo(content,':') == Clomosy.AppUserGUID {//
      if (clGetStringAfter(content,':') == 'uyesecim'){
        SetMobileState(True);
        soruCvp = GetQuestion(clMath.GenerateRandom(1,25));
        LblExplanation.Caption = 'Sen Çıktın!';
        ImgMobileBalloon.Visible = False;
        ImgMobileTitle.Visible = False;
        MyDevice.Vibrate(500);
        LblQuestion.Caption = 'Soru:'+#13+''
        LblQuestion.Caption = LblQuestion.Caption + clGetStringTo(soruCvp,'|');   //SORU
        dogruCvp = clGetStringAfter(soruCvp,'|');                 //CVP
      }else if (clGetStringAfter(content,':') == 'suredoldu'){
        ImgMobileBalloon.Visible = True;
        ImgMobileTitle.Visible = True;
        clComponent.SetupComponent(ImgMobileBalloon,'{"ImgUrl":"https://clomosy.com/demos/timer_baloons2.png"}');
        LblExplanation.Caption = 'SURENIZ DOLDU!!!';
        SetMobileState(False);
      }
    }

  }
  
  void MyMobileMQTTPublishReceived;
  var
    msj:string;
  {
    msj='';
    if (MyMobileMQTT.ReceivedAlright){
      if (Clomosy.PlatformIsMobile) {
        msj = MyMobileMQTT.ReceivedMessage;
        //ShowMessage(msj);
          if clGetStringTo(msj,'|') == 'WIN' {
            MobileMQTTMessageHandler(msj);
          }
      }
    }
  }
  
  
  void CekilisTimerOnTimer;
  {
    //
    LblCekilisPlayerName.Caption = QMemList.FieldByName('Member_Name').AsString;
    Clomosy.ProcessMessages;
    if(count==15){    //GUID
      count = 0;
      CekilisTimer.Enabled    = False;
      selectedMember = QMemList.FieldByName('Member_GUID').AsString;
      MyWinMQTT.Send('WIN'+'|'+selectedMember+':'+'uyesecim');
      BtnPlayerTimer.Visible = True;
      CountDownTimer.Enabled  = True;
      //SleepAndCall(500,)
      ACommand = 'ON1'
      timerShow;
      GetTimer.Enabled = True;
      exit;
    }
    QMemList.Next;
    if (QMemList.EOF) 
    {
      QMemList.First;
    }
    Inc(count);
  }
  
  void CountDownTimerOnTimer
  {
    BtnPlayerTimer.Caption = IntToStr(second);
    if second == 0 {    //Cekilis Yap Tekrardan
      MyWinMQTT.Send('WIN'+'|'+selectedMember+':'+'suredoldu');
      //LblMobileDisplay.Caption = 'SURENIZ DOLDU!!!';
      BtnPlayerTimer.Visible = False;
      CountDownTimer.Enabled = False;
      ACommand = 'OFF1';
      timerShow;
      GetTimer.Enabled = True;
      BtnPlayerTimer.Visible = True;
      BtnCekilisYapOnClick;
    }
    Dec(second);
    //
  }
  
  void BtnCevaplaOnClick;
  {
    if dogruCvp == EdtReply.Text {
      LblExplanation.Caption = 'DOGRU CEVAP!!!';
      ImgMobileBalloon.Visible = True;
      SetMobileState(False);
    }else{
      LblExplanation.Caption = 'YANLIŞ CEVAP!!!';
    }
    EdtReply.Text = '';
  }
  
  void winOnnBtnOnClick;
  {
    ACommand = 'ON1'
    timerShow;
    GetTimer.Enabled = True;
   // MyIotMqtt.Send('ON1');
  }
  void winOffBtnOnClick;{
    ACommand = 'OFF1'
    timerShow;
    GetTimer.Enabled = True;
  //  MyIotMqtt.Send('OFF1');
  }

  void MyWinMQTTStatusChanged;
  {
     If not MyWinMQTT.Connected { 
      MyWinMQTT.Connect;
   }
  }
  void MyMobileMQTTStatusChanged;
  {
     If not MyMobileMQTT.Connected { 
      MyMobileMQTT.Connect;
   }
  }
  
  
{       //MAIN
  
  if (not Clomosy.PlatformIsMobile) { //  Win Tarafi

      
    MyWinForm = TCLForm.Create(Self);
    MyWinForm.SetFormBGImage('https://clomosy.com/demos/bgmobil.png');
    
    LoopState = False;
    count = 0;
    second = 20;

    GetTimer = MyWinForm.AddNewTimer(MyWinForm,'GetTimer',500); // the action is triggered every 1 second.
    MyWinForm.AddNewEvent(GetTimer,tbeOnTimer,'timerShow'); // Calls timerShow Procedure
    GetTimer.Enabled = False;



    //PANEL => BAŞLIK VE ONN OFF BUTONU
    PnlTitleAndOnOff=MyWinForm.AddNewProPanel(MyWinForm,'PnlTitleAndOnOff');
    clComponent.SetupComponent(PnlTitleAndOnOff,'{"Align" : "MostTop","MarginTop":10,
    "Height":120}');
    
    //PANEL => ON VE OFF BUTONLARI  
    PnlOnOffControl=MyWinForm.AddNewProPanel(PnlTitleAndOnOff,'PnlOnOffControl');
    clComponent.SetupComponent(PnlOnOffControl,'{"Align" : "Left","MarginTop":5,"MarginBottom":5,"MarginLeft":5,
    "Width" :70}');
    
    BtnOnn = MyWinForm.AddNewProButton(PnlOnOffControl,'BtnOnn','ON');
    clComponent.SetupComponent(BtnOnn,'{"Align" : "MostTop","MarginTop":5,"MarginLeft":5,"MarginRight":5,
    "Height":50,"RoundHeight":10, "RoundWidth":10,"BorderColor":"1c92f4","BorderWidth":3,
    "BackgroundColor":"#ffffff","TextColor":"1c92f4","TextSize":15,"TextBold":"yes"}');
    BtnOnn.clTagInt = 0;
    MyWinForm.AddNewEvent(BtnOnn,tbeOnClick,'winOnnBtnOnClick');
    
    BtnOff = MyWinForm.AddNewProButton(PnlOnOffControl,'BtnOff','OFF');
    clComponent.SetupComponent(BtnOff,'{"Align" : "Top","MarginTop":5,"MarginLeft":5,"MarginRight":5,
    "Height":50,"RoundHeight":10, "RoundWidth":10,"BorderColor":"1c92f4","BorderWidth":3,
    "BackgroundColor":"#ffffff","TextColor":"1c92f4","TextSize":15,"TextBold":"yes"}');
    BtnOff.clTagInt = 0;
    MyWinForm.AddNewEvent(BtnOff,tbeOnClick,'winOffBtnOnClick');
    
    
    //BAŞLIK IMG
    ImgTitle = MyWinForm.AddNewProImage(PnlTitleAndOnOff,'ImgTitle');
    clComponent.SetupComponent(ImgTitle,'{"Align" : "Client","MarginTop":25,"MarginBottom":25,"MarginLeft":40,"MarginRight":40,
    "ImgUrl":"https://clomosy.com/demos/balonpatlatma.png", "ImgFit":"yes"}');
    
    //PANEL => BALON RESMİ
    PnlBalloon=MyWinForm.AddNewProPanel(MyWinForm,'PnlBalloon');
    clComponent.SetupComponent(PnlBalloon,'{"Align" : "Top","MarginTop":5,
    "Height" :120}');
    
    ImgBalloon = MyWinForm.AddNewProImage(PnlBalloon,'ImgBalloon');
    clComponent.SetupComponent(ImgBalloon,'{"Align" : "Right","MarginRight":10,
    "ImgUrl":"https://clomosy.com/demos/balloon3.png", "ImgFit":"yes"}');
    
    //PANEL => ÇEKİLİŞ İSİM VE BUTONU
    PnlCekilis=MyWinForm.AddNewProPanel(MyWinForm,'PnlCekilis');
    clComponent.SetupComponent(PnlCekilis,'{"Align" : "Top","MarginTop":5,
    "Height" :140}');
    
    LblCekilisPlayerName = MyWinForm.AddNewProLabel(PnlCekilis,'LblCekilisPlayerName','Oyuncu Bekleniyor');
    clComponent.SetupComponent(LblCekilisPlayerName,'{"Align" : "MostTop","Height":'+IntToStr(LblCekilisPlayerName.Height*2)+',"TextSize":35,"Margintop":10,
    "TextVerticalAlign":"center", "TextHorizontalAlign":"center","TextBold":"yes"}');
    
    BtnStart = MyWinForm.AddNewProButton(PnlCekilis,'BtnStart','BAŞLAT');
    clComponent.SetupComponent(BtnStart,'{"Align" : "Top","MarginTop":15,"MarginLeft":80,"MarginRight":80,
    "Height":50,"RoundHeight":20, "RoundWidth":20,"BackgroundColor":"#f42727",
    "TextColor":"#ffffff","TextSize":20,"TextBold":"yes"}');
     MyWinForm.AddNewEvent(BtnStart,tbeOnClick,'BtnCekilisYapOnClick');
    
    
    //PANEL => TİMER
    PnlTimer=MyWinForm.AddNewProPanel(MyWinForm,'PnlTimer');
    clComponent.SetupComponent(PnlTimer,'{"Align" : "Top","MarginTop":5,
    "Height" :130}');
    
    BtnPlayerTimer = MyWinForm.AddNewProButton(PnlTimer,'BtnPlayerTimer','');
    clComponent.SetupComponent(BtnPlayerTimer,'{"Align" : "Left","MarginTop":15,"MarginLeft":5,
    "Width":200,"TextColor":"#ffffff","TextSize":20,"TextBold":"yes","ImgUrl":"https://clomosy.com/demos/time.png", "ImgFit":"yes"}');
    BtnPlayerTimer.Caption = 'Oyuncunun Süresi';
    //BtnPlayerTimer.Visible = False;
    
    BtnTotalTimer = MyWinForm.AddNewProButton(PnlTimer,'BtnTotalTimer','');
    clComponent.SetupComponent(BtnTotalTimer,'{"Align" : "Right","MarginTop":15,"MarginRight":5,
    "Width":200,"TextColor":"#ffffff","TextSize":18,"TextBold":"yes","ImgUrl":"https://clomosy.com/demos/time2.png", "ImgFit":"yes"}');
    BtnTotalTimer.Caption = 'Toplam Süre';
    
    
    CountDownTimer= MyWinForm.AddNewTimer(MyWinForm,'CountDownTimer',1000);
    CountDownTimer.Enabled = false;
    MyWinForm.AddNewEvent(CountDownTimer,tbeOnTimer,'CountDownTimerOnTimer');
    
    
    
    CekilisTimer= MyWinForm.AddNewTimer(MyWinForm,'CekilisTimer',200);
    CekilisTimer.Enabled = false;
    MyWinForm.AddNewEvent(CekilisTimer,tbeOnTimer,'CekilisTimerOnTimer');
    
    
    
    
    
    MyWinMQTT = MyWinForm.AddNewMQTTConnection(MyWinForm,'MyWinMQTT');
    MyWinForm.AddNewEvent(MyWinMQTT,tbeOnMQTTPublishReceived,'MyWinMQTTPublishReceived');
    MyWinForm.AddNewEvent(MyWinMQTT,tbeOnMQTTStatusChanged,'MyWinMQTTStatusChanged');
    MyWinMQTT.Channel = 'clomosy';//project guid + channel
    MyWinMQTT.Connect;
    
    MyWinForm.Run;
    
    
    
    
  }
  else{                               //  Mobile Tarafi
    MyMobileForm = TCLForm.Create(Self);
    MyMobileForm.SetFormBGImage('https://clomosy.com/demos/bgmobil.png');
    dogruCvp = '';
    MyDevice=TclDeviceManager.Create; 
    
    
    ImgMobileTitle = MyMobileForm.AddNewProImage(MyMobileForm,'ImgMobileTitle');
    clComponent.SetupComponent(ImgMobileTitle,'{"Align" : "MostTop","MarginTop":20,"MarginLeft":20,"MarginRight":20,"Height":100,"ImgUrl":"https://clomosy.com/demos/balonpatlatma.png","ImgFit":"yes"}'); 
    
    
    ImgMobileBalloon = MyMobileForm.AddNewProImage(MyMobileForm,'ImgMobileBalloon');
    clComponent.SetupComponent(ImgMobileBalloon,'{"Align" : "Client","MarginBottom":10,"MarginTop":20,"MarginLeft":20,"MarginRight":20,"ImgUrl":"https://clomosy.com/demos/balloons.png","ImgFit":"yes"}');
    
    
    LblExplanation = MyMobileForm.AddNewProLabel(MyMobileForm,'LblExplanation','Bekleniyor...');
    clComponent.SetupComponent(LblExplanation,'{"Align" : "Bottom","Height":'+IntToStr(LblExplanation.Height*2)+',"TextSize":25,"MarginBottom":20,
    "TextVerticalAlign":"center", "TextHorizontalAlign":"center","TextBold":"yes"}');
    
    
    
    
    
    //SORU CEVAPLA ALANI
    //PANEL => FORM
    PnlForm=MyMobileForm.AddNewProPanel(MyMobileForm,'PnlForm');
    clComponent.SetupComponent(PnlForm,'{"Align" : "Client"}');
    PnlForm.Visible = False;
    
    //PANEL => BALONLAR VE ZAMAN
    PnlTopImg=MyMobileForm.AddNewProPanel(PnlForm,'PnlTopImg');
    clComponent.SetupComponent(PnlTopImg,'{"Align" : "MostTop","MarginTop":15,"Marginleft":15,"MarginRight":15,
    "Height":120}');
    
    ImgQuestionBalloons = MyMobileForm.AddNewProImage(PnlTopImg,'ImgQuestionBalloons');
    clComponent.SetupComponent(ImgQuestionBalloons,'{"Align" : "Center","Height":'+IntToStr(PnlTopImg.Height)+',"Width":'+IntToStr(PnlTopImg.Width)+',
    "ImgUrl":"https://clomosy.com/demos/balloon4.png","ImgFit":"yes"}');
    
    BtnQuestionPlayerTimer = MyMobileForm.AddNewProButton(PnlTopImg,'BtnQuestionPlayerTimer','');
    clComponent.SetupComponent(BtnQuestionPlayerTimer,'{"Align" : "Center","Height":'+IntToStr(PnlTopImg.Height/2)+',"Width":'+IntToStr(PnlTopImg.Width)+',
    "ImgUrl":"https://clomosy.com/demos/time3.png","ImgFit":"yes","TextColor":"#000000","TextSize":25,"TextBold":"yes"}');
    BtnQuestionPlayerTimer.Caption = '0';
    
    LblQuestionTitle = MyMobileForm.AddNewProLabel(PnlForm,'LblQuestionTitle','Sıra Sende!');
    clComponent.SetupComponent(LblQuestionTitle,'{"Align" : "Top","Height":'+IntToStr(LblQuestionTitle.Height*2)+',"TextSize":35,"Margintop":10,
    "TextVerticalAlign":"center", "TextHorizontalAlign":"center","TextColor":"#1c92f4","TextBold":"yes"}');
    
    //PANEL => SORU VE CEVAP KISMI
    PnlQuestion=MyMobileForm.AddNewProPanel(PnlForm,'PnlQuestion');
    clComponent.SetupComponent(PnlQuestion,'{"Align" : "Client","MarginTop":15,"Marginleft":25,"MarginRight":25,"MarginBottom":35}');
    
    LblQuestion = MyMobileForm.AddNewProLabel(PnlQuestion,'LblQuestion','Soru:'+#13+'');
    clComponent.SetupComponent(LblQuestion,'{"Align" : "MostTop","Height":90,"TextSize":20,"MarginTop":15,"Marginleft":35,"MarginRight":35,
    "TextVerticalAlign":"center", "TextHorizontalAlign":"center","TextColor":"#f42727","TextBold":"yes","BorderColor":"#f42727","BorderWidth":3,"RoundHeight":20,"RoundWidth":20}');
    
    
    EdtReply = MyMobileForm.AddNewProEdit(PnlQuestion,'EdtReply','Cevap Yaz...');
    clComponent.SetupComponent(EdtReply,'{"Align" : "Top","Height":50,"TextSize":20,"MarginTop":15,"Marginleft":65,"MarginRight":65,
    "TextVerticalAlign":"center", "TextHorizontalAlign":"center","TextColor":"#f42727","TextBold":"yes","BorderColor":"#f42727",
    "BorderWidth":3,"RoundHeight":20,"RoundWidth":20}');
    EdtReply.clTypeOfField = taFloat;
    
    BtnQuestionReply = MyMobileForm.AddNewProButton(PnlQuestion,'BtnQuestionReply','cevapla');
    clComponent.SetupComponent(BtnQuestionReply,'{"Align" : "Top","Height":50,"TextSize":20,"MarginTop":15,"Marginleft":95,"MarginRight":95,
    "TextVerticalAlign":"center", "TextHorizontalAlign":"center","TextColor":"#ffffff","TextBold":"yes","backgroundcolor":"#1c92f4",
    "RoundHeight":20,"RoundWidth":20}');
    MyMobileForm.AddNewEvent(BtnQuestionReply,tbeOnClick,'BtnCevaplaOnClick');
    
    
    MyMobileMQTT = MyMobileForm.AddNewMQTTConnection(MyMobileForm,'MyMobileMQTT');
    MyMobileForm.AddNewEvent(MyMobileMQTT,tbeOnMQTTPublishReceived,'MyMobileMQTTPublishReceived');
    MyMobileForm.AddNewEvent(MyMobileMQTT,tbeOnMQTTStatusChanged,'MyMobileMQTTStatusChanged');
    MyMobileMQTT.Channel = 'clomosy';//project guid + channel
    MyMobileMQTT.Connect;
    
    //MyIotMqtt = MyMobileForm.AddNewMQTTConnection(MyMobileForm,'MyIotMqtt');
    //MyIotMqtt.Channel = 'clomosy';//project guid + channel
    //MyIotMqtt.Connect;

    MyMobileForm.Run;
    
  }
}
