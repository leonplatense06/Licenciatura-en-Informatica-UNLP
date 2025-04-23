program crearArchivos;

const
  cantDet = 30;

type
  reg_mae = record
    cod: integer;
    nom: string[20];
    desc: string;
    stockAct: integer;
    stockMin: integer;
    precio: real;
  end;

  reg_det = record
    cod: integer;
    cant: integer;
  end;

  arch_mae = file of reg_mae;
  arch_det = file of reg_det;

var
  mae: arch_mae;
  det: arch_det;
  regM: reg_mae;
  regD: reg_det;
  i: integer;
  nombre: string;

begin
  { Crear archivo maestro }
  assign(mae, 'maestro');
  rewrite(mae);
  for i := 1 to 100 do begin
    regM.cod := i * 10;
    str(i, nombre);
    regM.nom := 'Producto' + nombre;
    regM.desc := 'Descripcion del producto ' + nombre;
    regM.stockAct := 50 + (i mod 25);
    regM.stockMin := 5 + (i mod 10);
    regM.precio := 20.0 + (i * 0.75);
    write(mae, regM);
  end;
  close(mae);

  { Crear archivos detalle }
  for i := 1 to cantDet do begin
    str(i, nombre);
    assign(det, 'detalle' + nombre);
    rewrite(det);

    regD.cod := 10 + i * 10; regD.cant := 1 + (i * 3 mod 10); write(det, regD);
    regD.cod := 40 + i * 10; regD.cant := 2 + (i * 2 mod 9); write(det, regD);
    regD.cod := 70 + i * 10; regD.cant := 3 + (i * 4 mod 8); write(det, regD);
    regD.cod := 100 + i * 10; regD.cant := 4 + (i * 5 mod 7); write(det, regD);
    regD.cod := 130 + i * 10; regD.cant := 5 + (i * 6 mod 6); write(det, regD);

    close(det);
  end;
end.
