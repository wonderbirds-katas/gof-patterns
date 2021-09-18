unit TestTRepository;

interface

uses
  DUnitX.TestFramework, System.Generics.Collections, Exercise;

type

  [TestFixture]
  TRepositoryTests = class
  public
    [Test]
    procedure Find_EmptyList_ReturnsListWith0Elements;
    [Test]
    procedure Find_AfterAdd_ReturnsListWith1Element;
  end;

implementation

uses
  Repository;

procedure TRepositoryTests.Find_EmptyList_ReturnsListWith0Elements;
var
  repo: TRepository;
  actual: TList<TExercise>;
begin
  repo := TRepository.Create;
  actual := repo.Find();

  Assert.AreEqual(0, actual.Count);

  actual.Free;
  repo.Free;
end;

procedure TRepositoryTests.Find_AfterAdd_ReturnsListWith1Element;
var
  repo: TRepository;
  rec: TExercise;
  actual: TList<TExercise>;
begin
  repo := TRepository.Create;
  rec.Name := 'Some Exercise';
  repo.Add(rec);
  actual := repo.Find();

  Assert.AreEqual(1, actual.Count);

  actual.Free;
  repo.Free;
end;

initialization

TDUnitX.RegisterTestFixture(TRepositoryTests);

end.
