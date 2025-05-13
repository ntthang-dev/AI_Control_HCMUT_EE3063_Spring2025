# Tóm tắt kiến thức Xử lý Thông tin Không Chắc Chắn (Uncertainty)

## I. Giới thiệu về Không Chắc Chắn trong AI và Robotics
1.  **Nguồn gốc của sự không chắc chắn:**
    * **Nhiễu cảm biến (Sensor Noise):** Cảm biến không hoàn hảo, trả về các giá trị đo lường có sai số.
    * **Nhiễu hành động/điều khiển (Action/Control Noise):** Hành động của robot không được thực hiện một cách chính xác tuyệt đối.
    * **Mô hình không hoàn hảo (Imperfect Models):** Mô hình toán học của môi trường hoặc robot là một sự xấp xỉ của thực tế.
    * **Tính ngẫu nhiên của môi trường (Environmental Stochasticity):** Môi trường có thể thay đổi một cách không thể đoán trước.
    * **Thiếu thông tin (Lack of Information):** Không có đủ dữ liệu để xác định chính xác trạng thái.
2.  **Tại sao cần xử lý không chắc chắn?**
    * Để robot có thể hoạt động một cách đáng tin cậy trong thế giới thực.
    * Để đưa ra các quyết định tối ưu dựa trên thông tin không đầy đủ hoặc nhiễu.
    * Để ước lượng trạng thái của hệ thống (ví dụ: vị trí robot).

## II. Lý thuyết Xác suất Cơ bản (Brief Review)
1.  **Biến ngẫu nhiên (Random Variable - RV):**
    * Biến mà giá trị của nó là một kết quả ngẫu nhiên của một hiện tượng.
    * Ví dụ: $X$ là kết quả của việc tung đồng xu ($X \in \{head, tail\}$).
2.  **Hàm mật độ xác suất (Probability Density Function - PDF) - cho RV liên tục:**
    * $p(x)$ hoặc $f_X(x)$.
    * Mô tả khả năng tương đối của một RV nhận một giá trị cụ thể.
    * $\int_{-\infty}^{\infty} p(x)dx = 1$.
    * $Pr[a \le X \le b] = \int_{a}^{b} p(x)dx$.
    * **Phân bố chuẩn (Normal/Gaussian Distribution):** Rất phổ biến để mô hình hóa nhiễu.
        * **Univariate (Đơn biến):** $\mathcal{N}(x; \mu, \sigma^2) = \frac{1}{\sigma\sqrt{2\pi}} e^{-\frac{1}{2}(\frac{x-\mu}{\sigma})^2}$
            * $\mu$: trung bình (mean).
            * $\sigma^2$: phương sai (variance).
        * **Multivariate (Đa biến):** $\mathcal{N}(x; \mu, \Sigma) = \frac{1}{\sqrt{(2\pi)^k |\Sigma|}} e^{-\frac{1}{2}(x-\mu)^T \Sigma^{-1} (x-\mu)}$
            * $\mu$: vector trung bình.
            * $\Sigma$: ma trận hiệp phương sai (covariance matrix).
3.  **Hàm khối xác suất (Probability Mass Function - PMF) - cho RV rời rạc:**
    * $P(X=x)$.
    * $\sum_x P(X=x) = 1$.
4.  **Xác suất đồng thời (Joint Probability):**
    * $p(x, y) = P(X=x \text{ and } Y=y)$.
5.  **Xác suất biên (Marginal Probability):**
    * $p(x) = \int p(x, y)dy$ (cho RV liên tục).
    * $P(X=x) = \sum_y P(X=x, Y=y)$ (cho RV rời rạc).
6.  **Xác suất có điều kiện (Conditional Probability):**
    * $p(x|y) = P(X=x | Y=y) = \frac{p(x,y)}{p(y)}$.
    * Đo lường xác suất của $X=x$ khi biết $Y=y$ đã xảy ra.
7.  **Định lý Bayes (Bayes' Rule):**
    * $p(x|y) = \frac{p(y|x)p(x)}{p(y)}$.
    * $p(x|y) = \eta \cdot p(y|x)p(x)$, với $\eta = 1/p(y)$ là hằng số chuẩn hóa.
    * **Posterior = (Likelihood * Prior) / Evidence.**
    * Cực kỳ quan trọng trong các bài toán ước lượng trạng thái.
8.  **Độc lập có điều kiện (Conditional Independence):**
    * $X$ và $Y$ độc lập có điều kiện cho trước $Z$ nếu $p(x,y|z) = p(x|z)p(y|z)$.
    * Hoặc $p(x|y,z) = p(x|z)$.

## III. Bài toán Định vị Robot (Robot Localization)
1.  **Mục tiêu:** Ước lượng vị trí (pose - bao gồm vị trí và hướng) của robot trong môi trường dựa trên các phép đo từ cảm biến và thông tin về hành động của robot.
2.  **Các yếu tố chính:**
    * **State ($x_t$):** Trạng thái của robot tại thời điểm $t$ (ví dụ: vị trí, hướng).
    * **Control Actions ($u_t$):** Các lệnh điều khiển được gửi đến robot (ví dụ: di chuyển về phía trước, xoay).
    * **Sensor Measurements ($z_t$):** Dữ liệu từ cảm biến (ví dụ: khoảng cách đến vật cản, nhận dạng landmark).
    * **Map (m):** Bản đồ của môi trường (nếu có).
3.  **Belief (Niềm tin):**
    * Biểu diễn sự không chắc chắn về trạng thái của robot bằng một phân bố xác suất $bel(x_t) = p(x_t | z_{1:t}, u_{1:t})$.
    * **Prediction (Dự đoán - Prior belief):** $\overline{bel}(x_t) = p(x_t | z_{1:t-1}, u_{1:t}) = \int p(x_t | u_t, x_{t-1}) bel(x_{t-1}) dx_{t-1}$.
        * $p(x_t | u_t, x_{t-1})$: **Motion Model (Mô hình chuyển động)** - mô tả xác suất robot chuyển đến trạng thái $x_t$ từ $x_{t-1}$ sau khi thực hiện hành động $u_t$.
    * **Update (Cập nhật - Posterior belief):** $bel(x_t) = \eta \cdot p(z_t | x_t) \overline{bel}(x_t)$.
        * $p(z_t | x_t)$: **Measurement Model (Mô hình đo lường)** - mô tả xác suất nhận được phép đo $z_t$ khi robot ở trạng thái $x_t$.

4.  **Giả định Markov:**
    * **Motion Model:** $p(x_t | x_{0:t-1}, z_{1:t-1}, u_{1:t}) = p(x_t | x_{t-1}, u_t)$. Trạng thái hiện tại chỉ phụ thuộc vào trạng thái ngay trước đó và hành động hiện tại.
    * **Measurement Model:** $p(z_t | x_{0:t}, z_{1:t-1}, u_{1:t}) = p(z_t | x_t)$. Phép đo hiện tại chỉ phụ thuộc vào trạng thái hiện tại.
    * Hệ thống được mô hình hóa như một **Hidden Markov Model (HMM)** hoặc **Dynamic Bayesian Network (DBN)**.

## IV. Bayesian Filter
* **Thuật toán đệ quy tổng quát để ước lượng belief.**
* **Các bước trong một vòng lặp:**
    1.  **Prediction Step:**
        $\overline{bel}(x_t) = \int p(x_t | u_t, x_{t-1}) bel(x_{t-1}) dx_{t-1}$
    2.  **Update Step (Correction Step):**
        $bel(x_t) = \eta \cdot p(z_t | x_t) \overline{bel}(x_t)$
* **Vấn đề:** Tích phân trong bước dự đoán và việc biểu diễn belief $bel(x_t)$ có thể rất phức tạp, không có dạng đóng (closed-form solution) trong trường hợp tổng quát.
* **Các giải pháp xấp xỉ:**
    * **Gaussian Filters (ví dụ: Kalman Filter, Extended Kalman Filter - EKF, Unscented Kalman Filter - UKF):** Giả định belief là phân bố Gaussian.
    * **Non-parametric Filters (ví dụ: Particle Filter, Histogram Filter):** Biểu diễn belief bằng một tập các mẫu hoặc một lưới rời rạc.

## V. Particle Filter (Sequential Monte Carlo - SMC)
* Là một bộ lọc Bayes đệ quy, không tham số (non-parametric).
* Biểu diễn belief $bel(x_t)$ bằng một tập hợp $M$ các **particles (hạt)** ngẫu nhiên: $\mathcal{X}_t = \{x_t^{[1]}, x_t^{[2]}, ..., x_t^{[M]}\}$.
* Mỗi particle $x_t^{[m]}$ là một giả thuyết về trạng thái hiện tại của robot.
* Có thể có trọng số $w_t^{[m]}$ đi kèm mỗi particle, thể hiện "tầm quan trọng" hoặc "xác suất" của giả thuyết đó.

1.  **Thuật toán cơ bản (SIR - Sampling Importance Resampling):**
    * **Initialization:** Khởi tạo $M$ particles (ví dụ: từ prior $p(x_0)$ hoặc phân bố đều nếu không có thông tin).
    * **Lặp lại cho mỗi bước thời gian $t$:**
        1.  **Prediction Step (Sampling/Propagation):**
            * Với mỗi particle $x_{t-1}^{[m]}$ từ tập $\mathcal{X}_{t-1}$:
            * Lấy mẫu một particle mới $x_t^{[m]} \sim p(x_t | u_t, x_{t-1}^{[m]})$ (tức là, cho particle cũ "di chuyển" theo motion model và thêm nhiễu).
            * Tạo ra tập particle dự đoán $\overline{\mathcal{X}}_t = \{ \overline{x}_t^{[1]}, ..., \overline{x}_t^{[M]} \}$.
        2.  **Weighting Step (Importance Sampling):**
            * Với mỗi particle dự đoán $\overline{x}_t^{[m]}$:
            * Tính trọng số (importance weight): $w_t^{[m]} = p(z_t | \overline{x}_t^{[m]})$ (dựa trên measurement model).
        3.  **Normalization:** Chuẩn hóa các trọng số để tổng của chúng bằng 1: $\tilde{w}_t^{[m]} = \frac{w_t^{[m]}}{\sum_{j=1}^M w_t^{[j]}}$.
        4.  **Resampling Step (Tái lấy mẫu):**
            * Tạo một tập particle mới $\mathcal{X}_t$ bằng cách lấy mẫu $M$ lần (có hoàn lại) từ tập particle dự đoán $\overline{\mathcal{X}}_t$, với xác suất chọn mỗi particle $\overline{x}_t^{[m]}$ tỉ lệ thuận với trọng số chuẩn hóa $\tilde{w}_t^{[m]}$ của nó.
            * Các phương pháp resampling phổ biến: Multinomial resampling (Roulette Wheel), Stratified resampling, Systematic resampling.
            * Mục đích: Loại bỏ các particle có trọng số thấp (ít có khả năng đúng) và nhân bản các particle có trọng số cao (có khả năng đúng hơn). Giúp chống lại hiện tượng suy thoái particle (particle degeneracy - khi hầu hết trọng số tập trung vào một vài particle).

2.  **Ưu điểm của Particle Filter:**
    * Có thể biểu diễn các phân bố belief phức tạp, đa mode (multi-modal).
    * Không yêu cầu mô hình tuyến tính hay nhiễu Gaussian (khác với Kalman Filter cơ bản).
    * Tương đối dễ triển khai.
3.  **Nhược điểm:**
    * Chi phí tính toán có thể cao nếu số lượng particle $M$ lớn.
    * Có thể bị suy thoái particle nếu không resampling hợp lý hoặc khi measurement model quá "sắc nét".
    * Có thể gặp khó khăn trong không gian trạng thái nhiều chiều (curse of dimensionality).

## VI. Ví dụ về Measurement Model (trong slide)
* Mô hình cho cảm biến khoảng cách (ví dụ: sonar, laser).
* Thường là sự kết hợp của nhiều phân bố:
    * $p_{hit}$: Phân bố Gaussian quanh khoảng cách thực tế đến vật cản (do nhiễu cảm biến).
    * $p_{short}$: Phân bố (ví dụ: hàm mũ giảm dần) cho các phép đo ngắn hơn thực tế (do vật cản không mong muốn, người đi qua).
    * $p_{max}$: Phân bố tại giá trị đo cực đại (khi không phát hiện được vật cản trong tầm hoạt động).
    * $p_{rand}$: Phân bố đều cho các phép đo ngẫu nhiên (do lỗi không giải thích được).
* Mô hình cuối cùng: $p(z_t|x_t, m) = \alpha_{hit} p_{hit} + \alpha_{short} p_{short} + \alpha_{max} p_{max} + \alpha_{rand} p_{rand}$.
    * Các $\alpha$ là các trọng số trộn, tổng bằng 1.
