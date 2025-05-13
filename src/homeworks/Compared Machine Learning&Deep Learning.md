# So sánh các Khái niệm Machine Learning và Deep Learning

## 1. So sánh ANN (Artificial Neural Network) và CNN (Convolutional Neural Network)

| Đặc điểm             | ANN (Artificial Neural Network - Mạng Nơ-ron Nhân tạo) | CNN (Convolutional Neural Network - Mạng Nơ-ron Tích chập) |
| :------------------- | :---------------------------------------------------- | :----------------------------------------------------------- |
| **Cấu trúc chung** | Các lớp nơ-ron kết nối đầy đủ (fully connected layers). Mỗi nơ-ron ở một lớp kết nối với tất cả các nơ-ron ở lớp trước và lớp sau (nếu có). | Bao gồm các lớp đặc thù như lớp Tích chập (Convolutional), lớp Gộp (Pooling) bên cạnh các lớp Kết nối đầy đủ (thường ở cuối mạng). |
| **Loại dữ liệu đầu vào hiệu quả** | Dữ liệu có cấu trúc dạng bảng, dữ liệu dạng vector đặc trưng đã được trích xuất. | Dữ liệu có cấu trúc dạng lưới (grid-like data) như hình ảnh, video, hoặc dữ liệu chuỗi có thể biểu diễn dưới dạng lưới (ví dụ: spectrogram âm thanh). |
| **Khả năng xử lý dữ liệu không gian/thời gian** | Hạn chế trong việc tự học các mối quan hệ không gian hoặc thời gian phức tạp trong dữ liệu thô (ví dụ: ảnh, video). Cần trích xuất đặc trưng thủ công. | Rất mạnh trong việc tự động học các đặc trưng không gian phân cấp từ dữ liệu thô (ví dụ: từ cạnh, góc đến các bộ phận, đối tượng trong ảnh). |
| **Số lượng tham số** | Có thể rất lớn nếu input có kích thước lớn (ví dụ: ảnh kích thước lớn) do tính chất kết nối đầy đủ. Dễ bị overfitting. | Giảm đáng kể số lượng tham số so với ANN truyền thống khi xử lý ảnh nhờ cơ chế: **Local Connectivity (Kết nối cục bộ)** và **Shared Weights (Chia sẻ trọng số)** trong các lớp tích chập. |
| **Đặc trưng chính** | - Các nơ-ron được tổ chức thành các lớp (input, hidden, output).<br>- Học thông qua lan truyền ngược (backpropagation) và các thuật toán tối ưu (ví dụ: Gradient Descent).<br>- Hàm kích hoạt (sigmoid, tanh, ReLU) để đưa tính phi tuyến. | - **Convolutional Layers:** Sử dụng các bộ lọc (kernels) để thực hiện phép tích chập, phát hiện các đặc trưng cục bộ (cạnh, góc, texture).<br>- **Pooling Layers:** Giảm kích thước không gian của feature maps, tăng tính bất biến với các thay đổi nhỏ.<br>- **Hierarchical Feature Learning:** Các lớp đầu học đặc trưng cấp thấp, các lớp sau học đặc trưng cấp cao hơn. |
| **Ví dụ ứng dụng** | Phân loại, hồi quy trên dữ liệu dạng bảng, nhận dạng mẫu cơ bản. | Phân loại ảnh, phát hiện đối tượng, phân đoạn ảnh, nhận dạng khuôn mặt, xử lý video. |
| **Slide tham khảo** | ANN.pdf, CNN.pdf (trang 7 so sánh CNN vs Regular NNs) | CNN.pdf, Alexnet.pdf (AlexNet là một kiến trúc CNN nổi tiếng) |

**Điểm chung:**
* Cả ANN và CNN đều là các mô hình học máy lấy cảm hứng từ mạng nơ-ron sinh học.
* Cả hai đều học từ dữ liệu thông qua việc điều chỉnh các trọng số kết nối giữa các nơ-ron.
* Cả hai đều có thể được sử dụng cho cả bài toán phân loại và hồi quy.
* Cả hai đều sử dụng các hàm kích hoạt và thuật toán lan truyền ngược để huấn luyện.

**Điểm khác biệt cốt lõi:** CNN được thiết kế đặc biệt để khai thác cấu trúc không gian trong dữ liệu (như ảnh) thông qua các lớp tích chập và gộp, giúp nó hiệu quả hơn và cần ít tham số hơn ANN truyền thống cho các tác vụ liên quan đến thị giác máy tính.

## 2. So sánh Học có giám sát (Supervised Learning), Học không có giám sát (Unsupervised Learning), và Học củng cố (Reinforcement Learning)

| Đặc điểm             | Học Có Giám Sát (Supervised Learning) | Học Không Có Giám Sát (Unsupervised Learning) | Học Củng Cố (Reinforcement Learning) |
| :------------------- | :--------------------------------------- | :------------------------------------------ | :-------------------------------------- |
| **Loại dữ liệu huấn luyện** | Dữ liệu được gán nhãn (labeled data). Mỗi mẫu đầu vào có một đầu ra (nhãn) mong muốn tương ứng. | Dữ liệu không được gán nhãn (unlabeled data). Chỉ có các mẫu đầu vào. | Không có tập dữ liệu huấn luyện cố định. Tác nhân (agent) học thông qua tương tác với một môi trường (environment). |
| **Mục tiêu chính** | Học một hàm ánh xạ từ đầu vào đến đầu ra đã biết để dự đoán đầu ra cho dữ liệu mới. | Khám phá cấu trúc, quy luật, hoặc các nhóm tiềm ẩn trong dữ liệu. | Học một chính sách (policy) hành động để tối đa hóa một phần thưởng (reward) tích lũy theo thời gian. |
| **Phản hồi (Feedback)** | Phản hồi trực tiếp và rõ ràng dưới dạng nhãn đúng cho mỗi mẫu huấn luyện. | Không có phản hồi trực tiếp về "độ đúng đắn". Đánh giá dựa trên các tiêu chí nội tại của dữ liệu (ví dụ: độ tương đồng trong cụm). | Phản hồi dưới dạng tín hiệu phần thưởng (reward/penalty) từ môi trường sau mỗi hành động. Phản hồi có thể bị trễ. |
| **Các tác vụ phổ biến** | - **Phân loại (Classification):** Dự đoán nhãn rời rạc (ví dụ: Perceptron, SVM, KNN, ANN, CNN).<br>- **Hồi quy (Regression):** Dự đoán giá trị liên tục (ví dụ: Linear Regression, KNN, ANN). | - **Phân cụm (Clustering):** Nhóm các đối tượng tương tự (ví dụ: K-Means).<br>- **Giảm chiều dữ liệu (Dimensionality Reduction):** (ví dụ: PCA - không có trong slide).<br>- **Học luật kết hợp (Association Rule Learning).** | - **Điều khiển (Control):** (ví dụ: Robot tự cân bằng - Cart-Pole).<br>- **Chơi game:** (ví dụ: AlphaGo).<br>- **Tối ưu hóa quyết định theo chuỗi.** |
| **Ví dụ thuật toán (từ slide)** | Perceptron, SVM (Linear, Soft Margin, Kernel), KNN, Linear Regression, ANN (MLP), CNN, Softmax, LSTM, RNN. | K-Means Clustering. | Q-Learning. |
| **Slide tham khảo** | K nearest neighbors.pdf (trang 2), K means clustering - 11032022.pdf (trang 4), Q learning.pdf (trang 2). | K means clustering - 11032022.pdf (trang 4). | Q learning.pdf (trang 2). |

## 3. So sánh Perceptron và SVM (Support Vector Machine)

| Đặc điểm             | Perceptron Learning Algorithm | SVM (Support Vector Machine) |
| :------------------- | :---------------------------- | :--------------------------- |
| **Mục tiêu** | Tìm một siêu phẳng bất kỳ có thể phân tách tuyến tính hai lớp dữ liệu. | Tìm siêu phẳng phân cách **tối ưu** (optimal hyperplane) có lề (margin) lớn nhất giữa hai lớp. |
| **Cách tìm siêu phẳng** | Thuật toán lặp, cập nhật trọng số khi gặp điểm bị phân loại sai. Dừng khi tất cả các điểm được phân loại đúng (nếu dữ liệu phân tách tuyến tính). | Giải một bài toán tối ưu lồi (convex optimization problem) để tối đa hóa lề. |
| **Lề (Margin)** | Không trực tiếp tối đa hóa lề. Có thể tìm ra nhiều siêu phẳng phân cách khác nhau. | Tối đa hóa lề, là khoảng cách từ siêu phẳng đến các điểm dữ liệu gần nhất của mỗi lớp (các support vectors). |
| **Support Vectors** | Không có khái niệm support vectors một cách tường minh như SVM. Siêu phẳng bị ảnh hưởng bởi tất cả các điểm (đặc biệt là các điểm bị phân loại sai trong quá trình học). | Siêu phẳng phân cách chỉ được xác định bởi các support vectors. Các điểm khác không ảnh hưởng đến vị trí của siêu phẳng (nếu chúng không vi phạm lề). |
| **Độ phức tạp của mô hình** | Mô hình tuyến tính đơn giản. | Có thể tạo ra các đường biên phi tuyến phức tạp bằng cách sử dụng **Kernel Trick** (ánh xạ dữ liệu lên không gian nhiều chiều hơn). |
| **Xử lý dữ liệu không phân tách tuyến tính** | Perceptron cơ bản không hội tụ nếu dữ liệu không phân tách tuyến tính. (Có các biến thể như Pocket Algorithm). | - **Soft Margin SVM:** Cho phép một số điểm bị phân loại sai hoặc nằm trong lề bằng cách đưa vào các biến bù (slack variables) và tham số C để kiểm soát sự đánh đổi giữa việc tối đa hóa lề và giảm thiểu lỗi phân loại.<br>- **Kernel SVM:** Xử lý hiệu quả dữ liệu không phân tách tuyến tính. |
| **Độ nhạy cảm với outliers** | Có thể nhạy cảm với outliers nếu chúng ảnh hưởng đến quá trình cập nhật trọng số. | Ít nhạy cảm hơn với outliers (so với một số thuật toán khác) do tập trung vào các support vectors và lề. Tuy nhiên, soft margin SVM có thể bị ảnh hưởng nếu C quá lớn. |
| **Slide tham khảo** | Perceptron.pdf | SVM.pdf, Soft margin SVM.pdf, Kernel SVM.pdf |

**Điểm chung:**
* Cả hai đều là thuật toán học có giám sát cho bài toán phân loại nhị phân (có thể mở rộng cho đa lớp).
* Cả hai đều cố gắng tìm một siêu phẳng để chia tách các lớp dữ liệu.

**Điểm khác biệt cốt lõi:** SVM tìm siêu phẳng "tốt nhất" bằng cách tối đa hóa lề, trong khi Perceptron chỉ tìm một siêu phẳng "đủ tốt" để phân tách dữ liệu (nếu có thể). SVM cũng linh hoạt hơn trong việc xử lý dữ liệu không phân tách tuyến tính thông qua soft margin và kernel trick.

## 4. So sánh Precision (Độ chính xác) và Recall (Độ phủ / Độ nhạy)

* **Precision** và **Recall** là hai thước đo quan trọng để đánh giá hiệu suất của một mô hình phân loại, đặc biệt trong các bài toán mà sự mất cân bằng giữa các lớp là đáng kể hoặc chi phí của việc phân loại sai giữa các lớp là khác nhau.
* Cả hai đều dựa trên 4 giá trị từ **Confusion Matrix**:
    * **True Positives (TP):** Số mẫu dương được dự đoán đúng là dương.
    * **True Negatives (TN):** Số mẫu âm được dự đoán đúng là âm.
    * **False Positives (FP):** Số mẫu âm bị dự đoán sai là dương (Lỗi Loại I - Type I Error).
    * **False Negatives (FN):** Số mẫu dương bị dự đoán sai là âm (Lỗi Loại II - Type II Error).

| Đặc điểm             | Precision (Độ chính xác) | Recall (Độ phủ / Độ nhạy / True Positive Rate) |
| :------------------- | :----------------------- | :------------------------------------------- |
| **Định nghĩa** | Tỷ lệ các mẫu được dự đoán là dương mà thực sự là dương. | Tỷ lệ các mẫu thực sự dương mà được mô hình dự đoán đúng là dương. |
| **Công thức** | $Precision = \frac{TP}{TP + FP}$ | $Recall = \frac{TP}{TP + FN}$ |
| **Ý nghĩa** | Trong số tất cả các mẫu mà mô hình dự đoán là "Lớp A", có bao nhiêu mẫu thực sự thuộc "Lớp A"?<br>Trả lời câu hỏi: "Khi mô hình dự đoán một mẫu là dương, nó đúng ở mức độ nào?" | Trong số tất cả các mẫu thực sự thuộc "Lớp A", mô hình đã tìm ra (nhận diện đúng) được bao nhiêu mẫu?<br>Trả lời câu hỏi: "Mô hình có bỏ sót nhiều mẫu dương không?" |
| **Tập trung vào** | Giảm thiểu False Positives (FP). | Giảm thiểu False Negatives (FN). |
| **Khi nào quan trọng?** | Khi chi phí của False Positive là cao. <br>Ví dụ: Phân loại email spam (FP: email quan trọng bị cho vào spam), chẩn đoán bệnh (FP: người khỏe mạnh bị chẩn đoán nhầm là có bệnh và phải điều trị không cần thiết). | Khi chi phí của False Negative là cao.<br>Ví dụ: Phát hiện gian lận (FN: giao dịch gian lận không bị phát hiện), chẩn đoán bệnh hiểm nghèo (FN: người bệnh không được phát hiện sớm). |
| **Trade-off** | Thường có sự đánh đổi giữa Precision và Recall. Tăng Precision có thể làm giảm Recall và ngược lại. (Ví dụ: nếu mô hình rất "thận trọng" và chỉ dự đoán dương khi rất chắc chắn, FP sẽ thấp -> Precision cao, nhưng có thể bỏ sót nhiều mẫu dương -> FN cao -> Recall thấp). |
| **Kết hợp (F1-Score)** | $F1 = 2 \cdot \frac{Precision \cdot Recall}{Precision + Recall}$. Là trung bình điều hòa của Precision và Recall, hữu ích khi muốn cân bằng cả hai. |

**(Slide tham khảo: Không có slide riêng về Precision/Recall, nhưng đây là các khái niệm cơ bản trong đánh giá mô hình phân loại, thường đi kèm với các thuật toán như Perceptron, SVM, KNN, ANN, CNN khi chúng được dùng cho phân loại.)**
