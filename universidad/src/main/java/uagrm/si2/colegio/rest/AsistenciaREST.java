package uagrm.si2.colegio.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import uagrm.si2.colegio.model.Asistencia;
import uagrm.si2.colegio.service.AsistenciaService;

import java.util.List;

@RestController
@RequestMapping("/asistencia/")
public class AsistenciaREST {

    @Autowired
    private AsistenciaService asistenciaService;


    private ResponseEntity<List<Asistencia>> getAllAsistencia(){
        return ResponseEntity.ok(asistenciaService.findAll());
    }

}
