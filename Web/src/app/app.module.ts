import { NgModule }       from '@angular/core';
import { BrowserModule }  from '@angular/platform-browser';
import { RouterModule }         from '@angular/router';
import { HttpModule } from '@angular/http';
import { FormsModule }   from '@angular/forms';

import { AppComponent }         from './app.component';
import { DashboardComponent }   from './dashboard.component';

import { PortfolioComponent }   from './portfolio.component';
import { PortFolioService}   from './portfolio.service';

import { UtilComponent }   from './util.component';

import { StockListComponent }   from './stocklist.component';
import { StockListService }     from './stocklist.service';
import { StockDetailComponent } from './stockdetail.component';
import { SearchBox }            from './search.box';
import { SearchName }           from './search.name';
import { SearchPipe }           from './search.pipe';

import { DropdownComponent }          from './dropdown.component';

import { AppRoutingModule }     from './app-routing.module';

import { PagerService } from './_services/index';

import { PrivateComponent }     from './auth.private.component'
import { LoginComponent }       from './auth.component'

import {GoogleChartComponent} from './GoogleChartComponent'

import { NgbModule } from '@ng-bootstrap/ng-bootstrap';

@NgModule({
  imports: [
    BrowserModule,
    HttpModule,
    FormsModule,
    AppRoutingModule,
    NgbModule.forRoot()
  ],
  declarations: [
    AppComponent,
    DashboardComponent,
    LoginComponent,
    PrivateComponent,
    PortfolioComponent,
    StockListComponent,
    StockDetailComponent,
    SearchBox,SearchName,SearchPipe,
    UtilComponent, DropdownComponent,
    GoogleChartComponent
  ],
  providers: [ StockListService, PagerService, PortFolioService ],
  bootstrap: [ AppComponent]
})
export class AppModule { }
