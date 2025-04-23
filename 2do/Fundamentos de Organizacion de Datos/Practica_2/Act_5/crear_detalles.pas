program crearDetalles;
type
  fe = record
    anio: integer;
    mes: integer;
    dia: integer;
  end;

  reg_det = record
    cod: integer;
    fecha: fe;
    tiempo: integer;
  end;

  arch_det = file of reg_det;

var
  det: arch_det;
  reg: reg_det;

begin
  assign(det, 'detalle1');
  rewrite(det);
  reg.cod := 1; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 1; reg.tiempo := 30; write(det, reg);
  reg.cod := 1; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 2; reg.tiempo := 45; write(det, reg);
  reg.cod := 2; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 1; reg.tiempo := 20; write(det, reg);
  reg.cod := 3; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 3; reg.tiempo := 50; write(det, reg);
  reg.cod := 3; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 5; reg.tiempo := 25; write(det, reg);
  close(det);

  assign(det, 'detalle2');
  rewrite(det);
  reg.cod := 1; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 3; reg.tiempo := 60; write(det, reg);
  reg.cod := 2; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 2; reg.tiempo := 15; write(det, reg);
  reg.cod := 2; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 4; reg.tiempo := 35; write(det, reg);
  reg.cod := 4; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 1; reg.tiempo := 20; write(det, reg);
  reg.cod := 4; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 2; reg.tiempo := 25; write(det, reg);
  close(det);

  assign(det, 'detalle3');
  rewrite(det);
  reg.cod := 3; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 6; reg.tiempo := 40; write(det, reg);
  reg.cod := 4; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 3; reg.tiempo := 50; write(det, reg);
  reg.cod := 5; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 1; reg.tiempo := 30; write(det, reg);
  reg.cod := 5; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 2; reg.tiempo := 10; write(det, reg);
  reg.cod := 5; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 3; reg.tiempo := 15; write(det, reg);
  close(det);

  assign(det, 'detalle4');
  rewrite(det);
  reg.cod := 1; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 4; reg.tiempo := 55; write(det, reg);
  reg.cod := 2; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 5; reg.tiempo := 35; write(det, reg);
  reg.cod := 4; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 4; reg.tiempo := 45; write(det, reg);
  reg.cod := 5; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 4; reg.tiempo := 25; write(det, reg);
  reg.cod := 5; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 5; reg.tiempo := 30; write(det, reg);
  close(det);

  assign(det, 'detalle5');
  rewrite(det);
  reg.cod := 3; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 7; reg.tiempo := 20; write(det, reg);
  reg.cod := 3; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 8; reg.tiempo := 35; write(det, reg);
  reg.cod := 4; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 5; reg.tiempo := 15; write(det, reg);
  reg.cod := 5; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 6; reg.tiempo := 10; write(det, reg);
  reg.cod := 5; reg.fecha.anio := 2025; reg.fecha.mes := 4; reg.fecha.dia := 7; reg.tiempo := 40; write(det, reg);
  close(det);
end.
