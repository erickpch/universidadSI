import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { appSettings } from '../../Settings/appSettings';
import { MateriaGestion } from '../../Models/materiaGestion';
import { Modalidad } from '../../Models/modalidad';
import { Aula } from '../../Models/aula';
import { Docente } from '../../Models/docente';
import { Materia } from '../../Models/materia';
import { Gestion } from '../../Models/gestion';


@Injectable({
  providedIn: 'root'
})
export class MateriaGestionService {

  private http = inject(HttpClient);
  private url: string = appSettings.apiURL + "materiaGestion/";


  constructor() {
  }

  listar() {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders().set('Authorization', `Bearer ${token}`);

    return this.http.get<MateriaGestion[]>(`${this.url}listar`, { headers });
  }

  buscarDocente(id: number, datos: Docente[]): Docente {
    for (let dato of datos) {
      if (dato.id === id) {
        return dato;
      }
    }
    return {
      id: 0,
      nombre: '',
      codigo: 0,
      ci: 0,
      profesion: '',
      genero: ''
    };
  }

  buscarGestion(id: number, datos: Gestion[]): Gestion{
    for (let dato of datos) {
      if (dato.id === id) {
        return dato;
      }
    }
    return {
      id: 0,
      nombre: "",
      year:0,
      tipo_gestion:{
        id:0,
        nombre:"",
        year:0
      }
    };
  }


  buscarAula(id: number, datos: Aula[]): Aula {
    for (let dato of datos) {
      if (dato.id === id) {
        return dato;
      }
    }
    return {
      id: 0,
      numero: 0,
      piso: 0,
      modulo: 0,
    };
  }

  buscarMateria(id: number, datos: Materia[]): Materia {
    for (let dato of datos) {
      if (dato.id === id) {
        return dato;
      }
    }
    return {
      id: 0,
      nombre: "",
      sigla: "",
      semestre: 0,
      carrera: {
        id:0,
        nombre:"",
        modalidad:{
          id:0,
          nombre: ""
        }
      },
    };
  }


  listarModalidad() {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders().set('Authorization', `Bearer ${token}`);
    console.log(appSettings.apiURL + "modalidad/listar");
    return this.http.get<Modalidad[]>(appSettings.apiURL + "modalidad/listar", { headers });
  }

  obtener(dato: number) {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders().set('Authorization', `Bearer ${token}`);

    return this.http.get<MateriaGestion>(this.url + "buscar/" + dato, { headers });
  }

  obtenerModalidad(dato: number) {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders().set('Authorization', `Bearer ${token}`);

    return this.http.get<Modalidad>(appSettings.apiURL + "modalidad/buscar/" + dato, { headers });
  }

  crear(dato: MateriaGestion) {
    const token = localStorage.getItem('token');

    const headers = new HttpHeaders().set('Authorization', `Bearer ${token}`);
    return this.http.post<MateriaGestion>(this.url + "crear", dato, { headers });
  }

  editar(dato: MateriaGestion) {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders().set('Authorization', `Bearer ${token}`);

    return this.http.post<MateriaGestion>(this.url + "editar", dato, { headers });
  }

  eliminar(dato: number) {
    const token = localStorage.getItem('token');

    const headers = new HttpHeaders().set('Authorization', `Bearer ${token}`);
    return this.http.get<MateriaGestion>(this.url + "delete/" + dato, { headers });
  }
}
