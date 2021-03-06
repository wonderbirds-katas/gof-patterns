unit TestUsingFireDAC;

interface

uses
  DUnitX.TestFramework, System.IOUtils;

type

  [TestFixture]
  TestTUsingFireDAC = class
  public
    [Test]
    procedure WhenCreateDbCreateTableInsertRow_ThenRowExists;
  end;

implementation

uses
  FireDAC.Comp.Client, FireDAC.Phys.SQLiteDef,
  System.Classes, Spring.Collections, Exercise, System.DateUtils, SysUtils,
  SqliteDatabaseConfiguration;

procedure TestTUsingFireDAC.
  WhenCreateDbCreateTableInsertRow_ThenRowExists;
var
  Connection: TFDConnection;
  Rows: IList<TDateTime>;
  Params: TFDPhysSQLiteConnectionDefParams;
  Query: TFDQuery;
  Value: TDateTime;
begin
  Connection := TFDConnection.Create(nil);
  Connection.ConnectionDefName := TSqliteDatabaseConfiguration.ConnectionDefinitionName;
  Connection.Connected := True;

  Connection.ExecSQL('CREATE TABLE IF NOT EXISTS exercises (id INTEGER PRIMARY KEY AUTOINCREMENT, start DATETIME)');
  Connection.ExecSQL('DELETE FROM exercises');

  Connection.ExecSQL('INSERT INTO exercises VALUES (NULL, ''2021-10-08T07:00:00.000Z'')');

  Query := TFDQuery.Create(nil);
  Query.Connection := Connection;
  Query.SQL.Text := 'SELECT start FROM exercises';
  Query.Open;

  Rows := TCollections.CreateList<TDateTime>;
  while not Query.Eof do
  begin
    Value := Query.FieldByName('start').AsDateTime;
    Rows.Add(Value);
    Query.Next;
  end;

  Query.Free;
  Connection.Free;

  Assert.AreEqual(1, Rows.Count, 'unexpected number of entries in DB.');
end;

initialization

TDUnitX.RegisterTestFixture(TestTUsingFireDAC);

end.
