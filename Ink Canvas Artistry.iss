; Ink Canvas Artistry 安装脚本 (修改版)
; 目标系统: Windows 7 SP1 / Windows 10 / Windows 11 (32位/64位通用)
; 架构: x86 (32位程序，在64位系统上通过WOW64兼容运行)
; 运行时: .NET Framework 4.7.2

#define MyAppName "Ink Canvas Artistry"
#define MyAppVersion "6.0"
#define MyAppPublisher "ChangSakura"
#define MyAppURL "https://github.com/InkCanvas/Ink-Canvas-Artistry"
#define MyAppExeName "Ink Canvas Artistry.exe"
#define MyAppAssocName MyAppName + " File"
#define MyAppAssocExt1 ".icart"
#define MyAppAssocExt2 ".icstk"
#define MyAppAssocKey1 StringChange(MyAppAssocName, " ", "") + MyAppAssocExt1
#define MyAppAssocKey2 StringChange(MyAppAssocName, " ", "") + MyAppAssocExt2

[Setup]
; 应用唯一标识符
AppId={{69D2B507-FAB8-4C81-A597-F36263C6A25E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}

; 安装路径: 自动识别 Program Files (32位) 或 Program Files (x86)
; {autopf} = 32位程序在64位系统上自动指向 Program Files (x86)
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}

; 输出设置
OutputDir=H:\tools\学科工具\Ink-Canvas-Artistry-master（修改版）
OutputBaseFilename=Ink.Canvas.Artistry.V{#MyAppVersion}.Setup
SetupIconFile=H:\tools\学科工具\Ink-Canvas-Artistry-master（修改版）\Ink Canvas\Resources\Ink Canvas Artistry.ico

; 压缩设置
Compression=lzma2/ultra64
SolidCompression=yes
LZMAUseSeparateProcess=yes

; 兼容性: 最低 Windows 7 SP1
; x86 程序天然兼容 32 位和 64 位 Windows
MinVersion=0,6.1sp1
ArchitecturesAllowed=x86compatible
ArchitecturesInstallIn64BitMode=x64compatible

; 权限: 课堂教具软件，无需管理员权限
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog

; UI 设置
WizardStyle=modern
DisableProgramGroupPage=yes

; 文件关联
ChangesAssociations=yes

; 卸载设置
Uninstallable=yes
UninstallDisplayName={#MyAppName}
UninstallDisplayIcon={app}\{#MyAppExeName},0

; 安装日志
SetupLogging=yes

[Languages]
Name: "chinese_simplified"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "创建桌面快捷方式"; GroupDescription: "附加图标:"; Flags: checkablealone
Name: "startupicon"; Description: "开机时自动启动"; GroupDescription: "附加选项:"; Flags: unchecked

[Files]
; 主程序
Source: "H:\tools\学科工具\Ink-Canvas-Artistry-master（修改版）\Ink Canvas\bin\Release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion; Check: IsDotNetInstalled
; 所有依赖文件和子目录
Source: "H:\tools\学科工具\Ink-Canvas-Artistry-master（修改版）\Ink Canvas\bin\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pdb,*.log"; Check: IsDotNetInstalled
; NOTE: 不要对共享系统文件使用 "Flags: ignoreversion"

[Registry]
; 文件扩展名 .icart
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocExt1}\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppAssocKey1}"; ValueData: ""; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey1}"; ValueType: string; ValueName: ""; ValueData: "{#MyAppAssocName}"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey1}\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey1}\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""
; 文件扩展名 .icstk
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocExt2}\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppAssocKey2}"; ValueData: ""; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey2}"; ValueType: string; ValueName: ""; ValueData: "{#MyAppAssocName}"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey2}\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey2}\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""
; 卸载时删除设置文件注册（可选）
Root: HKCU; Subkey: "Software\{#MyAppName}"; Flags: uninsdeletekeyifempty

[Icons]
; 开始菜单快捷方式
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Comment: "课堂电子教鞭工具"
; 桌面快捷方式
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; Comment: "课堂电子教鞭工具"
; 开机自启动
Name: "{userstartup}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: startupicon; Comment: "课堂电子教鞭工具"

[Run]
; 安装完成后可选择运行
Filename: "{app}\{#MyAppExeName}"; Description: "安装完成后立即运行 {#MyAppName}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
; 卸载时删除用户数据目录下的设置和日志
Type: filesandordirs; Name: "{userappdata}\{#MyAppName}"

[Code]
// ============================================================
// .NET Framework 4.7.2 运行时检测
// Win7 SP1 需要手动安装 .NET 4.7.2（KB4054566）
// Win10 1709+ 和 Win11 通常已内置
// ============================================================

function IsDotNetDetected(version: string): boolean;
var
  key, ver: string;
  release: Cardinal;
begin
  version := Trim(version);
  ver := version;
  // .NET 4.x 版本均通过统一的注册表键判断
  key := 'SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full';

  // 尝试 HKLM32（优先）
  if RegQueryDWordValue(HKLM32, key, 'Release', release) then begin
    // Release 值对应关系:
    // 460798 = .NET 4.7
    // 461308 = .NET 4.7.1
    // 461808 = .NET 4.7.2
    // 528040 = .NET 4.8
    // 528449 = .NET 4.8.1
    if ver = '4.7.2' then result := (release >= 461808)
    else if ver = '4.7.1' then result := (release >= 461308)
    else if ver = '4.7' then result := (release >= 460798)
    else if ver = '4.8' then result := (release >= 528040)
    else if ver = '4.8.1' then result := (release >= 528449)
    else result := (release >= 0);
  end
  else begin
    // 回退检查 HKLM64
    if RegQueryDWordValue(HKLM64, key, 'Release', release) then begin
      if ver = '4.7.2' then result := (release >= 461808)
      else if ver = '4.7.1' then result := (release >= 461308)
      else if ver = '4.7' then result := (release >= 460798)
      else if ver = '4.8' then result := (release >= 528040)
      else if ver = '4.8.1' then result := (release >= 528449)
      else result := (release >= 0);
    end
    else begin
      result := false;
    end;
  end;
end;

function IsDotNetInstalled: boolean;
begin
  result := IsDotNetDetected('4.7.2');
  // 如果没有 4.7.2，检查是否有更高版本（4.8 / 4.8.1 也兼容）
  if not result then
    result := IsDotNetDetected('4.8');
  if not result then
    result := IsDotNetDetected('4.8.1');
end;

// ============================================================
// 安装前检查: .NET 运行时 + 结束旧实例
// ============================================================
function InitializeSetup(): Boolean;
var
  ResultCode: Integer;
begin
  result := true;

  // 1. 尝试结束正在运行的旧实例
  Exec('taskkill.exe', '/f /im "{#MyAppExeName}"', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);

  // 2. 检测 .NET Framework 4.7.2+，缺失时弹警告
  if not IsDotNetInstalled then begin
    if MsgBox('未检测到 .NET Framework 4.7.2 或更高版本。' + #13#10 + #13#10 +
              '本软件需要 .NET Framework 4.7.2 才能正常运行。' + #13#10 +
              'Windows 10/11 用户可通过 Windows Update 获取。' + #13#10 +
              'Windows 7 用户需手动下载安装包。' + #13#10 + #13#10 +
              '是否仍要继续安装？', mbError, MB_YESNO) = IDNO then
    begin
      result := false;
    end;
  end;
end;
