package uagrm.si2.colegio.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.query.FluentQuery;
import org.springframework.stereotype.Service;
import uagrm.si2.colegio.model.Horario;
import uagrm.si2.colegio.repository.HorarioRepository;

import java.util.List;
import java.util.Optional;
import java.util.function.Function;

@Service
public class HorarioService {
    @Autowired
    private HorarioRepository horarioRepository;


}
