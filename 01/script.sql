

	CREATE TABLE reporte(
		idpos character varying(10) COLLATE pg_catalog."default",
		vendedor character varying(100) COLLATE pg_catalog."default",
		referencia character varying(35) COLLATE pg_catalog."default",
		"fecha venta" character varying(10) COLLATE pg_catalog."default",
		"id visita" character varying(10) COLLATE pg_catalog."default",
		cod_venta character varying(200) COLLATE pg_catalog."default",
	);

	CREATE OR REPLACE FUNCTION tgb_reporte() returns trigger as
	$BODY$
	BEGIN
		IF(TG_OP = 'DELETE') THEN
			RETURN OLD;
		END IF;

		SELECT FORMAT('%s%s%s%s%s',
			NEW.idpos,
			NEW."id visita",
			NEW."fecha venta",
			NEW.vendedor,
			RIGHT(NEW.referencia, 2)
		) into NEW.cod_venta;

		RETURN NEW;
	END
	$BODY$
	LANGUAGE PLPGSQL;

	CREATE TRIGGER tgb_reporte
	BEFORE INSERT OR UPDATE OR DELETE
	ON reporte
	FOR EACH ROW
	EXECUTE PROCEDURE tgb_reporte();


insert into reporte values ('1234567890', 'Vendedor1', 'referencia', '2000-01-01', '100', null) returning cod_venta
