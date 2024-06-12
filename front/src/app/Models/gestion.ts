export interface Gestion {
    id: number;
    nombre: string;
    year: number; 
    tipo_gestion: TipoGestion
}

export interface TipoGestion{
    id: number;
    nombre: string;
    year: number;   
}