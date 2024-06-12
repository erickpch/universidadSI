export interface Docente {
    id: number;
    nombre: string;
    codigo: number;
    ci: number;
    profesion: string;
    genero: string;
}

export interface DocenteCreate {
    nombre: string;
    codigo: number;
    ci: number;
    profesion: string;
    genero: string;
}