unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    procedure Edit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

{$R *.lfm}

{ TForm1 }

uses about;

var
  english:TextFile;
  turkish:TextFile;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  CloseFile(english);
  CloseFile(turkish);
  Application.Terminate;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Application.CreateForm(Tformabout, formabout);
  formabout.showmodal;
end;

procedure TForm1.Edit1Change(Sender: TObject);
var
  readword:String;
  readline:Integer;
  i:Integer;
begin
  reset(english);
  reset(turkish);
  readline:=0;

  repeat
    readln(english, readword);
    if (pos(edit1.text, readword)=1) then break;
    readline:=readline+1;
  until eof(english);

  for i:=0 to readline do readln(turkish, readword);

  memo1.Lines.Clear;
  memo1.Lines.Add(readword);

end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseFile(english);
  CloseFile(turkish);
  Application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  try
  AssignFile (english, 'share/english');
  Reset(english);
  AssignFile (turkish, 'share/turkish');
  Reset(turkish);
  except
    Showmessage('English or Turkish files can not find!');
    CloseFile(english);
    CloseFile(turkish);
    Application.Terminate;
  end;
end;




end.

