import { Component, Input, inject } from '@angular/core';
import { DocenteService } from '../../../Services/docente/docente.service';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { MatTableModule } from '@angular/material/table';
import {MatIconModule} from '@angular/material/icon';
import { Router } from '@angular/router';
import { Docente } from '../../../Models/docente';
import { LayoutComponent } from '../../layout/layout.component';
import {MatInputModule} from '@angular/material/input';
import {MatButtonModule} from '@angular/material/button';
import { MatOption, MatSelectModule } from '@angular/material/select';


@Component({
  selector: 'app-gestion-docente',
  standalone: true,
  imports: [
    LayoutComponent,
    ReactiveFormsModule,
    MatTableModule,
    MatIconModule,
    MatInputModule,
    MatButtonModule,
    MatSelectModule, 
    MatOption
  ],
  templateUrl: './gestion-docente.component.html',
  styleUrl: './gestion-docente.component.css'
})
export class GestionDocenteComponent {
  @Input('id') idDocente! : number;
  private docenteServicio = inject(DocenteService);
  public formBuild = inject(FormBuilder);
  public genero : string = "0";

  public formDocente:FormGroup = this.formBuild.group({
    nombre: [''],
    codigo:[''],
    ci:[],
    genero:[''],
    profesion:['']
  });

  constructor(private router:Router){}

  ngOnInit(): void {
    if(this.idDocente != 0){
      this.docenteServicio.obtener(this.idDocente).subscribe({
        next:(data) =>{
          this.formDocente.patchValue({
            nombre: data.nombre,
            ci:data.ci,
            codigo:data.codigo,
            genero: parseInt(data.genero) ,
            profesion:data.profesion
          })        
        },
        error:(err) =>{
          console.log(err.message)
        }
      })
    }
  }

guardar(){
  const objeto : Docente = {
    id : this.idDocente,
    nombre: this.formDocente.value.nombre,
    ci: this.formDocente.value.ci,
    genero:this.formDocente.value.genero,
    codigo:this.formDocente.value.codigo,
    profesion:this.formDocente.value.profesion,
  }

  console.log(objeto);
  if(this.idDocente == 0){
    this.docenteServicio.crear(objeto).subscribe({
      next:(data) =>{
        if(data){
          this.router.navigate(["/docentes"]);
        }else{
          alert("Error al crear")
        }
      },
      error:(err) =>{
        console.log(err.message)
        this.router.navigate(['/login']);
      }
    })
  }else{
    this.docenteServicio.editar(objeto).subscribe({
      next:(data) =>{
        if(data){
          this.router.navigate(["/docentes"]);
        }else{
          alert("Error al editar")
        }
      },
      error:(err) =>{
        console.log(err.message)
        this.router.navigate(['/login']);
      }
    })
  }


}

volver(){
  this.router.navigate(["/docentes"]);
}

}
