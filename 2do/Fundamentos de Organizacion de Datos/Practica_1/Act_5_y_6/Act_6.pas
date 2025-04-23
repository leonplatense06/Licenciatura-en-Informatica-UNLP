program celulares;

type
	string50 = string[50];
	cel = record
		cod:integer;
		precio:real;
		marca:string50;
		stockAct:integer;
		stockMin:integer;
		desc:string50;
		nom:string50;
	end;
	arch_cel = file of cel;
	arch_text = Text;

procedure leerCel (var c:cel);
begin
	write('Ingrese el Codigo del Celular (-1 Para Terminar): ');readln(c.cod);
	if (c.cod <> -1) then begin
		write('Ingrese la Marca del Celular: ');readln(c.marca);
		write('Ingrese el Nombre del Celular: ');readln(c.nom);
		write('Ingrese el Stock Minimo del Celular: ');readln(c.stockMin);
		write('Ingrese el Stock Disponible del Celular: ');readln(c.stockAct);
		write('Ingrese el Precio del Celular: ');readln(c.precio);
		write('Ingrese la Descripcion del Celular: ');readln(c.desc);
	end;
end;

procedure menu (var op:integer);
begin
	writeln();
	writeln('MENU:');
	writeln();
	write('1- Exportar de Archivo de Texto a Archivo Binario.', LineEnding, '2- Mostrar Celulares Con Stock Insuficiente.', LineEnding, '3- Buscar Celulares Por su Descripcion.', LineEnding, '4- Exportar a Archivo TXT.', LineEnding, '5- Agregar un Celular al Archivo.', LineEnding, '6- Modificar Stock.', LineEnding, '7- Exportar a TXT Celulares Sin Stock.', LineEnding, '0- Salir.', LineEnding, 'Eleccion: ');
	readln(op);
end;

procedure cargarRegDesdeTxt (var arcTxt:arch_text; var c:cel);
begin
	readln(arcTxt, c.cod, c.precio, c.marca);
	readln(arcTxt, c.stockAct, c.stockMin, c.desc);
	readln(arcTxt, c.nom);
end;

procedure asignarNoms (var arc:arch_cel; var arcTxt:arch_text);
var
	nom:string[12];
begin
	write('Ingrese el Nombre del Archivo Binario: ');readln(nom);
	assign(arc, nom);
	assign(arcTxt, 'celulares.txt');
end;

procedure importarDesdeTxt (var arc:arch_cel; var arcTxt:arch_text);
var
	c:cel;
begin
	rewrite(arc);reset(arcTxt);
	while not (eof(arcTxt)) do begin
		cargarRegDesdeTxt(arcTxt, c);
		write(arc, c);
	end;
	close(arc);close(arcTxt);
	writeln('-----------------------', LineEnding, 'ARCHIVO TXT EXPORTADO A ARCHIVO BINARIO', LineEnding, '-----------------------')
end;

procedure imprimirCelular (c:cel; var i:integer);
begin
	writeln();
	writeln('-------------------', LineEnding, 'CELULAR. (', i, ')');
	i := i + 1;
	writeln('Marca: ', c.marca, '.');
	writeln('Modelo: ', c.nom, '.');
	writeln('Codigo: ', c.cod, '.');
	writeln('Precio: $', c.precio:0:2, '.');
	writeln('Stock Minimo: ', c.stockMin, '.');
	writeln('Stock Disponible: ', c.stockAct, '.');
	writeln('Descripcion:', c.desc, '.');
	writeln('-------------------');
end;

procedure buscarDesc (var arc:arch_cel);
var
	d:string50;
	c:cel;
	i:integer;
begin
	reset(arc);
	i := 1;
	write('Descripcion: ');readln(d);
	while not (eof(arc)) do begin
		read(arc, c);
		if (Pos(d, c.desc) <> 0) then
			imprimirCelular(c, i);
	end;
end;

procedure imprimirStockInsuficiente (var arc:arch_cel);
var
	c:cel;
	i:integer;
begin
	i := 1;
	reset(arc);
	while not(eof(arc)) do begin
		read(arc, c);
		if (c.stockAct < c.stockMin) then
			imprimirCelular(c, i);
	end;
	close(arc);
end;

procedure exportarAArchivoDeTexto (var arc:arch_cel; var arcTxt:arch_text);
var
	c:cel;
begin
	reset(arc);rewrite(arcTxt);
	while not (eof(arc)) do begin
		read(arc, c);
		writeln(arcTxt, c.cod,' ', c.precio:0:2,' ', c.marca);
		writeln(arcTxt, c.stockAct,' ', c.stockMin,' ', c.desc);
		writeln(arcTxt, c.nom);
	end;
	close(arc);close(arcTxt);
	writeln('---------------------------------------', LineEnding, 'ARCHIVO BINARIO EXPORTADO A ARCHIVO TXT', LineEnding, '---------------------------------------')
end;

procedure agregarCelular (var arc:arch_cel);
var
	c:cel;
begin
	leerCel(c);
	reset(arc);
	while (c.cod <> -1) do begin
		seek(arc, filesize(arc));
		write(arc, c);
		writeln();
		writeln('-------------------', LineEnding, 'CELULAR AGREGADO.', LineEnding, '-------------------');
		writeln();
		leerCel(c);
	end;
	close(arc);
end;

procedure modificarStock (var arc:arch_cel);
var
	nuevoStock:integer;
	nomCel:string50;
	seguir:boolean;
	c:cel;
begin
	reset(arc);
	seguir := true;
	write('Ingrese el Nombre del Celular a Modificar: ');readln(nomCel);
	write('Ingrese el Nuevo Stock: ');readln(nuevoStock);
	while not (eof(arc)) and seguir do begin
		read(arc, c);
		if (c.nom = nomCel) then
			seguir := false;
	end;
	if (seguir) then
		writeln('-------------------', LineEnding, nomCel, 'NO ENONTRADO', LineEnding, '-------------------')
	else begin
		seek(arc, filepos(arc)-1);
		c.stockAct := nuevoStock;
		write(arc, c);
		writeln('-------------------', LineEnding, 'STOCK MODIFICADO.', LineEnding, '-------------------');
	end;
end;

procedure exportarSinStock (var arc:arch_cel; var arcTxt:arch_text);
var
	c:cel;
begin
	assign(arcTxt, 'C:\Users\lavie\OneDrive\Documentos\Facultad\FOD\Practica_1\Act_5_y_6\SinStock.txt');
	rewrite(arcTxt);
	reset(arc);
	while not (eof(arc)) do begin
		read(arc, c);
		if (c.stockAct = 0) then begin
			writeln(arcTxt, c.cod,' ', c.precio:0:2,' ', c.marca);
			writeln(arcTxt, c.stockAct,' ', c.stockMin,' ', c.desc);
			writeln(arcTxt, c.nom);
		end;
	end;
	close(arcTxt);close(arc);
	assign(arcTxt, 'celulares.txt');
end;	

var
	arc:arch_cel;
	arcTxt:arch_text;
	op:integer;
begin
	menu(op);
	if (op <> 0) then
		asignarNoms(arc, arcTxt);
	while (op <> 0) do begin
		case op of
			1:importarDesdeTxt(arc, arcTxt);
			2:imprimirStockInsuficiente(arc);
			3:buscarDesc(arc);
			4:exportarAArchivoDeTexto(arc, arcTxt);
			5:agregarCelular(arc);
			6:modificarStock(arc);
			7:exportarSinStock(arc, arcTxt);
		end;
		menu(op);
	end;
end.
