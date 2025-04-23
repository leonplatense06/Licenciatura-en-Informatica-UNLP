program generarArchivoHorasExtras;

type
  emp = record
    dpto: integer;
    division: integer;
    codEmple: integer;
    cate: integer;
    cantHoras: integer;
  end;

  arch = file of emp;

var
  archivo: arch;
  e: emp;
begin
  assign(archivo, 'archivo_horas_extras');
  rewrite(archivo);

  // Departamento 1 - División 1 - Empleado 101 (2 registros)
  e.dpto := 1; e.division := 1; e.codEmple := 101; e.cate := 3; e.cantHoras := 5; write(archivo, e);
  e.dpto := 1; e.division := 1; e.codEmple := 101; e.cate := 3; e.cantHoras := 4; write(archivo, e);

  // Departamento 1 - División 1 - Empleado 102
  e.codEmple := 102; e.cate := 2; e.cantHoras := 6; write(archivo, e);

  // Departamento 1 - División 2 - Empleado 201
  e.division := 2; e.codEmple := 201; e.cate := 4; e.cantHoras := 7; write(archivo, e);

  // Departamento 2 - División 1 - Empleado 301 (2 registros)
  e.dpto := 2; e.division := 1; e.codEmple := 301; e.cate := 1; e.cantHoras := 3; write(archivo, e);
  e.dpto := 2; e.division := 1; e.codEmple := 301; e.cate := 1; e.cantHoras := 5; write(archivo, e);

  // Departamento 2 - División 2 - Empleado 401
  e.division := 2; e.codEmple := 401; e.cate := 5; e.cantHoras := 8; write(archivo, e);

  close(archivo);
  writeln('Archivo "archivo_horas_extras" generado exitosamente.');
end.
