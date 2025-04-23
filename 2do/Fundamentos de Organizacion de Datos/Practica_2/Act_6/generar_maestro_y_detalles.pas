program generarMaestroYDetalles;

const
  d = 10;

type
  reg_det = record
    codLoc: integer;
    codCepa: integer;
    casosAct: integer;
    casosNue: integer;
    casosRec: integer;
    casosFall: integer;
  end;

  reg_mae = record
    codLoc: integer;
    nomLoc: string[30];
    codCepa: integer;
    nomCepa: string[30];
    casosAct: integer;
    casosNue: integer;
    casosRec: integer;
    casosFall: integer;
  end;

  arch_det = file of reg_det;
  arch_mae = file of reg_mae;

var
  mae: arch_mae;
  det: arch_det;
  regM: reg_mae;
  regD: reg_det;
  i, j, codL, codC: integer;
  num: string;

begin
  // CREAR MAESTRO
  assign(mae, 'maestro');
  rewrite(mae);

  for codL := 1 to 5 do
    for codC := 1 to 3 do begin
      regM.codLoc := codL;
      str(codL, regM.nomLoc);
      regM.nomLoc := 'Loc' + regM.nomLoc;
      regM.codCepa := codC;
      str(codC, regM.nomCepa);
      regM.nomCepa := 'Cepa' + regM.nomCepa;
      regM.casosAct := random(30);
      regM.casosNue := random(10);
      regM.casosRec := random(5);
      regM.casosFall := random(3);
      write(mae, regM);
    end;

  close(mae);

  // CREAR DETALLES
  for i := 1 to d do begin
    Str(i, num);
    assign(det, 'detalle' + num);
    rewrite(det);

    // 6 registros válidos por detalle (todos existen en el maestro)
    regD.codLoc := 1; regD.codCepa := 1; regD.casosAct := 10; regD.casosNue := 3; regD.casosRec := 1; regD.casosFall := 0; write(det, regD);
    regD.codLoc := 1; regD.codCepa := 2; regD.casosAct := 5;  regD.casosNue := 2; regD.casosRec := 0; regD.casosFall := 1; write(det, regD);
    regD.codLoc := 2; regD.codCepa := 1; regD.casosAct := 7;  regD.casosNue := 1; regD.casosRec := 1; regD.casosFall := 0; write(det, regD);
    regD.codLoc := 3; regD.codCepa := 3; regD.casosAct := 12; regD.casosNue := 4; regD.casosRec := 2; regD.casosFall := 0; write(det, regD);
    regD.codLoc := 4; regD.codCepa := 2; regD.casosAct := 9;  regD.casosNue := 1; regD.casosRec := 1; regD.casosFall := 1; write(det, regD);
    regD.codLoc := 5; regD.codCepa := 3; regD.casosAct := 6;  regD.casosNue := 0; regD.casosRec := 0; regD.casosFall := 0; write(det, regD);

    close(det);
  end;

  writeln('Maestro y 10 archivos detalle generados correctamente.');
end.
