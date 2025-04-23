program imprimirDatosDeArchivo;
const vA = (-1);

type
	mesa = record
		codProv:integer;
		codLoc:integer;
		codMesa:integer;
		cantVotos:integer;
	end;
	
	arch:file of mesa;

procedure asignarArc (var arc:arch);
begin
	assign(arc, 'votos');
end;

procedure leer (var arc:arch; var regM:mesa);
begin
	if (not eof(arc)) then
		read(arc, regM)
	else
		regM.codProv := vA;
end;

procedure mostrarEnPantalla (var arc:arch);
var
	regM:mesa;
	codLocAct, codProvAct, votosTotProv, votosTot:integer;
begin
	reset(arc);
	leer(arc, regM);
	while (regM.codProv <> vA) do begin
		codProvAct := regM.codProv;
		votosTotProv := 0;
		codLocAct := 
	
	
	
	
	
	
	
	
