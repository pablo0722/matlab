
%% Calculo de la matriz base de la transformada y su normalizacion
function [base,R] = base_Q(Fs, f0, b)
%   [b,R] = base_DPDT(N, Fs, P0, P)
%   Fs:     (in) Frecuencia de sampleo [Hz]
%   f0:     (in) Primer frecuencia que detecta [Hz]
%   b:      (in) Relacion entre las frecuencias de interes 2^(1/b)
%   [base]: (out) Matriz de la base
%   [R]:    (out) Factor de normalizacion

%% Introduccion
% La matriz de la base de la transformada NO es cuadrada. Tiene dimension
% NxM, con N = size del bloque, y M = cantidad de frecuencias que puede
% representar teniendo en cuenta que arranca en f0, aumenta con un factor
% de $$ 2^\frac{k}{b} $$ (k: numero natural) hasta Fs/2.
% Entonces:
%
% $$ f0 * 2^\frac{M}{b} = F_{max} $$
%
% $$ M = b * log_2 ( \frac{F_{max}}{f0} ) = b * log_2 ( \frac{(Fs/2)}{f0} ) =  b * \frac{log_e ( \frac{(Fs/2)}{f0}}{log_e (2)} $$
%
% *Nota: se debe redondear M hacia abajo
%
% Esta transformada se basa en la matriz base de la DFT, la cual son
% fasores complejos de frecuencias multiplos enteros de una frecuencia base
%
% $$ Base\_FT = e^{jwt};\ con\ w: frecuencia\ del\ fasor\ en\ [\frac{rad}{seg}],\ y\ t: tiempo $$
%
% $$ Base\_DFT = e^{j(\frac{2\pi k Fs}{N})(nTs)};\ con\ (\frac{2\pi k Fs}{N}): frecuencia\ del\ fasor\ en\ [\frac{rad}{seg}],\ y\ (nTs): sampleo $$
%
% $$ Donde\ (\frac{2\pi Fs}{N})\ es\ la\ frecuencia\ base\ y\ k \in \aleph\ son\ los\ multiplos\ enteros\ de\ dicha\ frecuencia $$
%
% $$ Donde\ Ts\ es\ el\ periodo\ de\ sampleo\ y\ n\in \aleph\ son\ los\ multiplos\ enteros\ de\ dicho\ periodo $$
%
% La base de esta transformada utiliza una frecuencia base exponencial como
% la escala musical, es decir, no usa multiplos enteros de una frecuencia
% base, sino que utiliza una frecuencia elevada a un exponente entero.
%
% $$ Base\_CQT = e^{j(2\pi 2^\frac{k}{b}f0)(nTs)};\ con\ (2\pi 2^\frac{k}{b}f0): frecuencia\ del\ fasor\ en\ [\frac{rad}{seg}],\ y\ (nTs): sampleo $$
%
% $$ Donde\ (2\pi 2^\frac{k}{b}f0)\ es\ la\ frecuencia\ y\ k \in \aleph\ es\ la\ potencia\ de\ dicha\ frecuencia $$
%
% f0: Primer frecuencia que detecta la transformada
%
% $$ 2^\frac{1}{b} $$: Razon, base de la exponencial, de la escala
%
% Para aplicarse a la escala musical b debe ser 12, que es la cantidad de
% notas que hay en cada octava.
%
% La CQT es como un banco de filtros donde cada filtro tiene una frecuencia
% central f[k], un ancho de banda y un factor de selectividad Q.
%
% $$ f[k] = f0 * 2^\frac{k}{b} $$
%
% $$ \Delta[k] = f[k+1] - f[k]  = f0 * 2^\frac{k+1}{b} - f0 * 2^\frac{k}{b} = f0 * 2^\frac{k}{b}(2^\frac{1}{b} - 1) = f[k](2^\frac{1}{b} - 1) $$
%
% $$ Q = \frac{f[k]}{\Delta[k]} = \frac{1}{(2^\frac{1}{b} - 1)} $$
%
% Se ve que el factor de selectividad Q es independiente de k (constante)
% ya que a medida que aumenta la frecuencia central del filtro, tambien
% aumenta el ancho de banda en la misma proporcion.
%
% Esta transformada, además, tiene un limite de la sumatoria, y por lo tanto
% una normalizacion, que depende de la frecuencia, es decir, depende de k.
%
% $$ N[k] = Q * \frac{Fs}{fk} = \frac{1}{(2^\frac{1}{b} - 1)} * \frac{Fs}{f0 * 2^\frac{k}{b}} $$
%

%% Constantes
    Ts=1/Fs;    % Periodo de sampleo
    
    Fmax = Fs/2;
    
    P = 2^(1/b);
    
    M = fix(b * log2(Fmax/f0)); % Calculo M (segunda dimension de la base)
    
    Nmax = fix(Fs/(f0*(P - 1)));                     % Nmax = N[k] , k = 0
    
    
%% Inicializo base
    base = zeros(Nmax,M);  % Inicializo la base
    R = zeros(1, M);
    
    
%% Calculo base
    for k = 0:M-1
        
        Nk = Nmax / (P^k);
        
        for n = 0:Nmax-1      
                % (P0*(P^k)*2*pi) representa la frecuencia [rad/seg] del fasor
                % (n*Ts) representa el sampleo (en tiempo) del fasor
                if n < Nk
                    arg = (f0*(P^k)*2*pi*n*Ts);
                    base(n+1,k+1) = exp(-1i*arg);
                else
                    base(n+1,k+1) = 0;
                end
        end
        R(k+1) = Nk;
    end
    
    
%% Calculo Normalizacion
% La normalizacion es la norma al cuadrado de la base, o lo que es lo
% mismo, el producto interno de la base por si misma
%
% $$ || \O ||^2 =\ < \O , \O >\ = \sum_{0}^{N[k]-1} (\O) * (\O^*) = \sum_{0}^{N[k]-1} e^{j(2\pi P^kP0)(nTs)} * e^{-j(2\pi P^kP0)(nTs)} = \sum_{0}^{N[k]-1} 1 = N[k] $$
%
end