use auditor;

CREATE OR REPLACE VIEW vw_detalle_sucursales AS (
	SELECT  e.nom_empresa AS Empresa, s.num_sucursal AS NumSuc, s.nom_sucursal AS NomSuc, s.telefono AS telefonoSuc,
			loc.ref_localidad AS Localidad, CONCAT(r.nombre," ", r.apellido) AS Regional, r.telefono AS telefonoReg
	FROM sucursales AS s
	INNER JOIN empresas AS e INNER JOIN localidades AS loc INNER JOIN regionales AS r
	ON e.id_empresa = s.id_empresa AND loc.id_localidad = s.id_localidad AND r.id_regional = s.id_regional
	ORDER BY Empresa, NumSuc
);
-- SELECT * FROM vw_detalle_sucursales;

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

CREATE OR REPLACE VIEW vw_observados_semana AS (
	SELECT DISTINCT c.cod_obs AS CodObs, c.ref_codigo AS Referencia, COUNT(o.cod_obs) AS Total	
	FROM legajos AS l
	INNER JOIN observados AS o INNER JOIN codigos AS c
	ON l.num_cuenta = o.num_cuenta AND o.cod_obs = c.cod_obs
	WHERE WEEK(l.fecha_otorg) = WEEK(CURRENT_DATE()) AND l.cod_estado = 25
	GROUP BY CodObs, Referencia ORDER BY Total DESC
);
-- SELECT * FROM vw_observados_semana;

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

CREATE OR REPLACE VIEW vw_pendientes_regional AS (
	SELECT e.nom_empresa AS Empresa, CONCAT(r.nombre, " ", r.apellido) AS Regional, COUNT(cod_obs) AS Total
	FROM legajos AS l
	INNER JOIN sucursales AS s INNER JOIN regionales AS r INNER JOIN observados AS o INNER JOIN empresas AS e
	ON s.id_sucursal = l.id_sucursal AND l.num_cuenta = o.num_cuenta AND r.id_regional = s.id_regional AND e.id_empresa = s.id_empresa
	WHERE l.cod_estado = 20
	GROUP BY Regional, Empresa ORDER BY Total DESC
);
-- SELECT * FROM vw_pendientes_regional;

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

CREATE OR REPLACE VIEW vw_filtraComentarios AS (
	SELECT l.num_cuenta AS Cuenta, com.comentario AS Comentario, com.fecha_coment AS Fecha
	FROM legajos AS l
    INNER JOIN comentarios AS com ON l.num_cuenta = com.num_cuenta 
    WHERE comentario LIKE "%autori%"
);
-- SELECT * FROM vw_filtraComentarios LIMIT 10;

-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

CREATE OR REPLACE VIEW vw_panorama AS (
	SELECT em.id_empresa, em.nom_empresa, s.id_sucursal, l.num_sucursal, s.nom_sucursal, loc.ref_localidad, loc.sector, s.latitud, s.longitud, s.categoria, re.id_regional, CONCAT(re.nombre, ' ', re.apellido) AS Regional,
		l.num_cuenta, l.cod_estado, es.ref_estado, l.fecha_obs, o.cod_obs, co.ref_codigo, ref.ref_referencia, com.id_comentario, com.comentario, com.fecha_coment 
	FROM legajos AS l
    INNER JOIN sucursales AS s ON s.id_sucursal = l.id_sucursal
	INNER JOIN observados AS o ON l.num_cuenta = o.num_cuenta
    INNER JOIN empresas AS em ON em.id_empresa = s.id_empresa
    INNER JOIN localidades AS loc ON loc.id_localidad = s.id_localidad
    INNER JOIN regionales AS re ON re.id_regional = s.id_regional
    INNER JOIN codigos AS co ON co.cod_obs = o.cod_obs
    INNER JOIN estados AS es ON es.cod_estado = l.cod_estado
	INNER JOIN referencia AS ref ON ref.cod_referencia = co.cod_referencia    
	LEFT JOIN comentarios AS com ON com.num_cuenta = l.num_cuenta
    GROUP BY  em.id_empresa, em.nom_empresa, s.id_sucursal, l.num_sucursal, s.nom_sucursal, loc.ref_localidad, loc.sector, s.categoria, re.id_regional, l.num_cuenta, l.cod_estado, es.ref_estado, l.fecha_obs,
           o.cod_obs, co.ref_codigo, ref.ref_referencia, com.id_comentario, com.comentario, com.fecha_coment 
);
-- SELECT * FROM vw_panorama;
